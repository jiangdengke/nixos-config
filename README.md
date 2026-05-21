# nixos-config

这是一个 flake 化的 NixOS 配置。当前主机名是 `nixos`，flake 输出名也是 `nixos`，默认用户是 `jdk`。

参考资料：

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki: nixos-generate-config](https://wiki.nixos.org/wiki/Nixos-generate-config)
- [NixOS Wiki: Flakes](https://wiki.nixos.org/wiki/Flakes)

## 新机器安装

### 1. 启动安装介质

用 Ventoy 启动官方 NixOS ISO。进到终端后先联网，能 ping 通外网就行。

有线网络通常直接插网线；无线网络可以用：

```bash
nmtui
```

如果 GitHub 访问不通，先临时走可用代理或镜像，把仓库和 flake 输入拉下来再继续。

### 2. 分区和格式化

这套配置默认是 UEFI + `systemd-boot` + `btrfs`。磁盘 swap 不必保留，系统里已经启用了 `zramSwap`。

下面是示例命令。`DISK` 是整块磁盘，后面的 `*_PART` 是分区路径。NVMe 通常是 `/dev/nvme0n1p1`，SATA 通常是 `/dev/sda1`，按你的机器替换。

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

### 5. 生成并替换硬件配置

先让 NixOS 根据当前机器生成硬件配置：

```bash
nixos-generate-config --root /mnt
```

再把生成出来的硬件配置覆盖到仓库里：

```bash
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/nixos-config/nixos/hardware-configuration.nix
```

这一步很重要。仓库里的旧 `hardware-configuration.nix` 是上一台机器的 UUID，不能直接拿到新机器上用。

### 6. 安装系统

如果安装环境里 flakes 还没开，先临时启用：

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
```

然后安装：

```bash
nixos-install --flake '.#nixos'
```

### 7. 重启

```bash
reboot
```

第一次进系统后，这套配置会自动在 TTY1 登录 `jdk`，然后启动 Niri 会话。

## 日常更新

在仓库目录里执行：

```bash
sudo nixos-rebuild switch --flake '.#nixos'
```

迁移到新机器时，优先检查这些文件：

- `nixos/hardware-configuration.nix`
- `modules/dae/config.dae`
- `modules/boot.nix`
- `modules/nvidia-gpu.nix`
