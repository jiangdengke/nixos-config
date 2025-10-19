{ pkgs, ... }:

{
  programs.zsh = {
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = pkgs.writeTextFile {
          name = "p10k-config";
          text = builtins.readFile ./p10k.zsh;
          destination = "/p10k.zsh";
        };
        file = "p10k.zsh";
      }
    ];
  };

  # 安装 powerlevel10k 推荐的字体
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "MesloLGL Nerd Font" "MesloLGL Nerd Font Mono" "Noto Sans CJK SC" ];
      serif = [ "MesloLGL Nerd Font" "Noto Serif CJK SC" ];
      sansSerif = [ "MesloLGL Nerd Font" "Noto Sans CJK SC" ];
    };
  };
}
