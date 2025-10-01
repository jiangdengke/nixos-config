{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
    golangci-lint
    delve
    gotools
  ];

  # 可选：给 GOPATH/GOBIN 一个位置（模块时代不是必须，但装工具会方便）
  home.sessionVariables = {
    GOPATH = "$HOME/go";
    GOBIN  = "$HOME/go/bin";
  };

  # 可选：把 GOBIN 加进 PATH（如果你用 go install 安装工具）
  home.sessionPath = [ "$HOME/go/bin" ];
}

