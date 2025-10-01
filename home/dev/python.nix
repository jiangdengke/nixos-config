{ pkgs, ... }:

let
  # 选定 Python 版本：把这一行改成你要的，比如 python311 / python312 / python313（视 nixpkgs 提供而定）
  py = pkgs.python314;

  # 可选：自带常用包的 Python 解释器（与上面二选一）
  pyWithPkgs = py.withPackages (ps: with ps; [
    pip setuptools wheel
    ipython
    # 需要再加：numpy pandas matplotlib requests
  ]);
in {
  home.packages = with pkgs; [
    # 二选一：要“纯净”就用 py；想带内置包就用 pyWithPkgs
    py
    # pyWithPkgs

    uv          # 超快 venv/pip 管理（强烈推荐）
    pipx        # 隔离安装 CLI 工具（如 black, ruff 也可用 pipx 管理）
    ruff        # Linter（也可装 ruff-lsp 做 LSP）
    black       # 格式化
    isort       # import 排序
    pyright     # 语言服务器（VS Code/Neovim LSP 用）
    # 可按需：jupyterlab pre-commit ruff-lsp
  ];

  # 防止误用全局 pip（强烈建议）
  home.sessionVariables.PIP_REQUIRE_VIRTUALENV = "1";

  # 确保 pipx 安装的可执行文件能进 PATH
  home.sessionPath = [ "$HOME/.local/bin" ];

  # 可选：pip 全局配置（例：超时/镜像）
  xdg.configFile."pip/pip.conf".text = ''
    [global]
    timeout = 60
    # index-url = https://pypi.tuna.tsinghua.edu.cn/simple
  '';
}

