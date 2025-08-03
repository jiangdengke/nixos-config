{ config, pkgs, ... }:

{
  # Starship 配置
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    # Starship 设置
    settings = {
      # 添加空行
      
      # 全局设置
      format = "$all$fill$cmd_duration$line_break$character";
      
      # 设置字符样式
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
        vicmd_symbol = "[V](bold green)";
      };
      
      # 填充区域（使用右侧信息）
      fill = {
        symbol = " ";
      };
      
      # 目录配置
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 1;
        style = "bold cyan";
        repo_root_style = "bold cyan";
        read_only = " 🔒";
        format = "[$path]($style)[$read_only]($read_only_style) ";
      };
      
      # Git 分支配置
      git_branch = {
        symbol = "🌱 ";
        truncation_length = 10;
        truncation_symbol = "…";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };
      
      # Git 状态配置 - 使用双引号避免语法错误
git_status = {
  format = "[$all_status$ahead_behind ]($style)";
  style = "bold red";
  conflicted = "≠";
  ahead = "↑$count";
  behind = "↓$count";
  diverged = "↕";
  untracked = "?";
  stashed = "📦";
  modified = "!";
  staged = "+";
  renamed = "»";
  deleted = "✘";
};
      
      # 命令执行时间
      cmd_duration = {
        min_time = 500;
        format = "[$duration](bold yellow)";
        show_milliseconds = false;
      };
      
      # Nix Shell 指示器
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol$name]($style) ";
        style = "bold blue";
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
      };
      
      # 包信息
      package = {
        format = "[$symbol$version]($style) ";
        style = "bold 208";
        display_private = true;
      };
      
      # Python 环境 - 修复语法错误
      python = {
        format = "[$symbol$pyenv_prefix($version )(\\($virtualenv\\) )]($style)";
        symbol = "🐍 ";
        style = "bold green";
      };
      
      # Node.js 版本
      nodejs = {
        format = "[$symbol($version )]($style)";
        symbol = "⬢ ";
        style = "bold green";
      };
      
      # Rust 版本
      rust = {
        format = "[$symbol($version )]($style)";
        symbol = "🦀 ";
        style = "bold red";
      };
      
      # Docker 上下文
      docker_context = {
        format = "[$symbol$context]($style) ";
        symbol = "🐳 ";
        style = "blue bold";
        only_with_files = true;
      };
      
      # 内存使用
      memory_usage = {
        disabled = false;
        threshold = 75;
        symbol = "🧠 ";
        style = "bold dimmed green";
        format = "$symbol[$ram_pct]($style) ";
      };
      
      # 任务数量
      jobs = {
        symbol = "✦";
        style = "bold blue";
        number_threshold = 1;
        format = "[$symbol $number]($style)";
      };
      
      # 用户名显示
      username = {
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style)@";
        show_always = false;
      };
      
      # 主机名显示
      hostname = {
        ssh_only = true;
        format = "[$hostname]($style) in ";
        style = "bold dimmed green";
      };
    };
  };
}
