# nixos-config

个人 NixOS 配置，使用 Niri 和 Home Manager。当前 flake 输出为 `nixos`，主机名为 `nixos`，用户为 `jdk`。

## 配置结构

```text
flake.nix                       # 输入、格式化器和主机输出
hosts/nixos/
  default.nix                   # 本机硬件模块、账户、Home Manager 用户绑定
  hardware-configuration.nix    # 当前机器生成的磁盘与平台配置
modules/
  default.nix                   # 通用系统模块入口
  home-manager.nix              # Home Manager 通用集成设置
  users.nix                     # 系统级 Shell 设置
  desktop.nix                   # Portal、蓝牙和输入设备
  nix.nix                       # Flakes、缓存、GC 和兼容 overlay
  boot.nix / power.nix           # 引导与电源管理
  dae/default.nix               # 可选 DAE 服务，读取运行时私有配置
home/
  default.nix                   # 通用环境、PATH 和模块入口
  desktop.nix                   # 图形应用与桌面组件入口
  dev/                          # Go、Python、PHP
  programs/                     # 通用工具与 Git
  nvim/ / zsh/ / yazi/           # 编辑器、Shell 和文件管理器
  waybar/                       # 状态栏配置与独立脚本
```

`flake.nix` 负责装配；主机配置决定账户、GPU 和 DAE 服务；`modules/` 提供通用系统设置；`home/` 管理用户环境。用户名只在主机配置中定义，Home Manager 从系统账户继承用户名与主目录。

系统和 Home Manager 的 `stateVersion` 保持 `25.05`。更新依赖不需要修改这两个值。

## 从旧配置迁移

### DAE 私有配置

DAE 现在读取 `/etc/dae/config.dae`，不再把仓库中的配置复制到 Nix store。本地旧文件 `modules/dae/config.dae` 保留在磁盘上，但已退出 Git 跟踪并被忽略；新克隆的仓库不包含它。

在已有 NixOS 机器上，首次切换前执行：

```bash
sudo install -Dm600 modules/dae/config.dae /etc/dae/config.dae
```

如果配置来自其他私有位置，将源路径替换为实际位置。不要使用 `builtins.readFile` 或 Nix 路径字面量引用这份文件。

不需要 DAE 时，移除 `hosts/nixos/default.nix` 中的 `../../modules/dae` 导入。之后不需要准备 DAE 配置。

### API 凭据与账户密码

Zsh 从 `${ZDOTDIR}/local.zsh` 加载本机设置；当前路径是 `~/.config/zsh/local.zsh`。该文件不由 Home Manager 管理，也不应放入仓库：

```bash
install -d -m700 "$HOME/.config/zsh"
touch "$HOME/.config/zsh/local.zsh"
chmod 600 "$HOME/.config/zsh/local.zsh"
```

在此文件中按需设置 `ANTHROPIC_BASE_URL`、`ANTHROPIC_AUTH_TOKEN`、`OPENAI_BASE_URL` 和 `OPENAI_API_KEY`。仓库不提供这些值。

硬编码的 API 凭据和账户初始密码已从当前配置移除。现有账户密码不会因此自动改变；需要时在目标机器执行 `passwd` 和 `sudo passwd root`。

旧凭据仍可能存在于 Git 历史及旧的 Nix store 路径中。此次重构不重写历史；曾提交的 API 凭据需要在提供方轮换。

## 新机器安装

### 1. 启动安装介质

用 Ventoy 启动官方 NixOS ISO，先确认网络可用。有线网络通常直接插网线；无线网络可以使用：

```bash
nmtui
```

如果 GitHub 无法访问，先准备可用代理或镜像，再获取仓库与 flake 输入。

### 2. 分区和格式化

配置使用 UEFI、`systemd-boot` 和 `btrfs`，已启用 `zramSwap`。下列命令会清空所选磁盘；先确认磁盘及分区路径。

示例使用 NVMe。SATA 磁盘的分区路径通常是 `/dev/sda1`、`/dev/sda2`。

```bash
sudo -i

DISK=/dev/nvme0n1
EFI_PART=/dev/nvme0n1p1
ROOT_PART=/dev/nvme0n1p2

parted --script "$DISK" mklabel gpt \
  mkpart ESP fat32 1MiB 1025MiB \
  set 1 esp on \
  mkpart primary btrfs 1025MiB 100%

mkfs.fat -F 32 -n BOOT "$EFI_PART"
mkfs.btrfs -f -L NIXOS "$ROOT_PART"
```

### 3. 挂载文件系统

```bash
mount /dev/disk/by-label/NIXOS /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt

mount -o subvol=root,compress=zstd,noatime /dev/disk/by-label/NIXOS /mnt
mkdir -p /mnt/{home,nix,boot}
mount -o subvol=home,compress=zstd,noatime /dev/disk/by-label/NIXOS /mnt/home
mount -o subvol=nix,compress=zstd,noatime /dev/disk/by-label/NIXOS /mnt/nix
mount /dev/disk/by-label/BOOT /mnt/boot
```

### 4. 获取配置

```bash
cd /mnt
git clone https://github.com/jiangdengke/nixos-config.git nixos-config
cd nixos-config
```

### 5. 替换硬件配置

```bash
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/nixos-config/hosts/nixos/hardware-configuration.nix
```

仓库中的 UUID 和磁盘 swap 来自原机器，必须替换。生成的文件会反映本机实际文件系统与 swap。

同时检查 `hosts/nixos/default.nix`：选择适用的 GPU 模块、用户名、自动登录和触控板设置。当前配置启用 NVIDIA，禁用触控板。

### 6. 准备 DAE 配置

如果保留 DAE 导入，从私有位置安装配置；替换下面的源路径：

```bash
install -Dm600 /path/to/private/config.dae /mnt/etc/dae/config.dae
```

如果移除了 DAE 导入，跳过此步。

### 7. 安装并设置用户密码

如果安装环境尚未启用 flakes：

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

安装系统后，为默认用户设置密码；如果修改了用户名，替换 `jdk`：

```bash
nixos-install --flake '.#nixos'
nixos-enter --root /mnt -c 'passwd jdk'
reboot
```

`nixos-install` 默认会提示设置 root 密码。仓库不再提供预设账户密码。

### 8. 启动桌面

系统会在 TTY1 自动登录 `jdk`。登录后执行：

```bash
niri-session
```

当前没有配置自动启动 Niri。Waybar、Polkit 随图形会话的 systemd 用户服务启动。XWayland Satellite 由 Niri 25.08 按需启动，不再额外运行用户服务。

Zim 框架由锁定的 nixpkgs 提供，模块版本与哈希记录在 `home/zsh/zim-sources.json`。首次登录只在用户缓存目录生成初始化文件，无需克隆 `~/zimfw`，也不在 Shell 启动时下载模块。

## 从旧配置迁移 Neovim

Neovim 改为 Home Manager 逐文件管理，不再删除整个配置目录。旧版本留下的普通文件若与新版本不同，首次切换会报文件冲突；先备份再切换。以下命令只移动配置目录，不删除插件数据：

```bash
config_root="${XDG_CONFIG_HOME:-$HOME/.config}"
state_root="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
if [ -d "$config_root/nvim" ] && [ ! -L "$config_root/nvim" ]; then
  mkdir -p "$state_root"
  # 保留旧配置中由 :Lazy update 更新过的锁文件。
  if [ -f "$config_root/nvim/lazy-lock.json" ] && [ ! -e "$state_root/lazy-lock.json" ]; then
    cp "$config_root/nvim/lazy-lock.json" "$state_root/lazy-lock.json"
  fi
  backup_dir=$(mktemp -d "$config_root/nvim-before-nix.XXXXXX")
  mv "$config_root/nvim" "$backup_dir/nvim"
  printf 'Neovim 配置已保留在 %s/nvim\n' "$backup_dir"
fi
```

此后修改仓库的 `home/nvim/nvim/` 并重新构建。Lazy 的可写锁文件位于 `$XDG_STATE_HOME/nvim/lazy-lock.json`（默认 `~/.local/state/nvim/lazy-lock.json`），不会被切换覆盖。语言服务器由 Nix 提供，通过 Neovim 0.11 内置 LSP 启用，不再通过 Mason 重复安装。

## 桌面软件源覆盖

`modules/desktop-packages.nix` 单独固定 QQ 和 Chrome 的新版本、下载源及 SHA-256，解决旧源下架问题，不改变 `flake.lock`。QQ 每次下载从官方接口取得临时 URL，再校验固定内容哈希；临时 URL 不写入配置。后续升级 nixpkgs 时，应核对并移除已不需要的覆盖。

LocalSend 由系统模块管理，并开放 TCP/UDP 53317；UDisks2 为用户的 udiskie 服务提供自动挂载后端。

## 日常检查与更新

在仓库目录执行。新增的 Nix 模块或脚本必须先纳入 Git 跟踪，本地 Git flake 才会包含它们：

```bash
git add <新增文件路径>
nix flake check
nix build '.#nixosConfigurations.nixos.config.system.build.toplevel' --no-link
```

保留 DAE 时，锁定版本的上游模块会在求值中构建资源目录。首次检查允许构建这些依赖，不使用 `nix flake check --no-build`。

确认构建通过、私有 DAE 配置就位后，先临时激活验证，再持久切换：

```bash
sudo nixos-rebuild test --flake '.#nixos'
sudo nixos-rebuild switch --flake '.#nixos'
```

Home Manager 随 NixOS 一起部署，不单独执行 `home-manager switch`。Zsh 的 `update` 和 `hmupdate` 都在仓库根目录调用 `nixos-rebuild --flake .`，按本机主机名选择输出。`nixconf` 编辑仓库根目录的 `flake.nix`。

格式化 Nix 文件可以执行 `nix fmt <文件路径>`。

参考资料：

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [nixos-generate-config](https://wiki.nixos.org/wiki/Nixos-generate-config)
- [Flakes](https://wiki.nixos.org/wiki/Flakes)
