{ config, pkgs, lib, ... }:

{
  # 使用 neovim-unwrapped 作为基础包
  home.packages = with pkgs; [
    neovim-unwrapped
    
    # Neovim 依赖的工具
    lua-language-server
    stylua
    ripgrep
    
    # Go 相关工具
    gopls
    golangci-lint
    delve
    go
    gotools
    
    # Python 相关工具
    pyright
    python3
    python3Packages.black
    python3Packages.flake8
    python3Packages.isort
    python3Packages.pylint
    
    # Nix 相关工具
    nixpkgs-fmt
  ];

  # 将 nvim 目录递归复制到 ~/.config/nvim
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  # 确保 XDG 目录存在
  xdg.enable = true;

  # 设置 Neovim 为默认编辑器
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  
  
  # 如果您使用 zsh，也添加相同的别名
  programs.zsh.shellAliases = {
    nvim = "${pkgs.neovim-unwrapped}/bin/nvim";
    vim = "${pkgs.neovim-unwrapped}/bin/nvim";
    vi = "${pkgs.neovim-unwrapped}/bin/nvim";
  };
}
