{ pkgs, ... }:

let
  # 选择 PHP 版本：php81 / php82 / php83 / php84（视 nixpkgs 提供而定）
  # 默认使用最新稳定版
  php = pkgs.php84;

  # 可选：带扩展的 PHP（如果需要额外的扩展，可以在这里配置）
  phpWithExtensions = php.buildEnv {
    extensions = ({ enabled, all }: enabled ++ (with all; [
      # 常用扩展（很多已默认启用，这里列出常见需求）
      # redis
      # imagick
      # xdebug
    ]));
    extraConfig = ''
      memory_limit = 256M
      upload_max_filesize = 50M
      post_max_size = 50M
      max_execution_time = 300
    '';
  };
in {
  home.packages = with pkgs; [
    # PHP 解释器（二选一）
    php                    # 纯净版
    # phpWithExtensions    # 带自定义配置和扩展

    # PHP 包管理和开发工具
    php84Packages.composer # Composer 包管理器
    phpactor               # PHP 语言服务器（LSP）
    # nodePackages.intelephense  # 备选 LSP（功能更强，但需要许可证）

    # 代码质量工具
    php84Packages.phpstan  # 静态分析
    # php-cs-fixer         # 代码格式化（可选，nixpkgs 中可能没有）
    # phpmd                # 代码质量检测（可选）

    # 调试工具（如果需要）
    # php84Packages.xdebug
  ];

  # 可选：PHP 相关环境变量
  home.sessionVariables = {
    # Composer 全局安装路径
    COMPOSER_HOME = "$HOME/.config/composer";
  };

  # 将 Composer 全局 bin 目录加入 PATH
  home.sessionPath = [ "$HOME/.config/composer/vendor/bin" ];

  # 可选：Composer 配置
  xdg.configFile."composer/config.json".text = builtins.toJSON {
    # 配置 Composer 镜像（如果需要）
    # repositories = [
    #   {
    #     type = "composer";
    #     url = "https://mirrors.aliyun.com/composer/";
    #   }
    # ];
  };
}
