{ pkgs, ... }:

let
  php = pkgs.php83.withExtensions (ext: with ext; [
    curl dom fileinfo gd intl mbstring openssl pcntl pdo_mysql redis sqlite3 tokenizer xml zip
    xdebug
  ]);
in {
  home.packages = [
    php
    pkgs.php83Packages.composer
  ];

  # 常见 Xdebug 远程调试配置，可按需调整端口/模式
  xdg.configFile."php/conf.d/99-xdebug.ini".text = ''
    [xdebug]
    xdebug.mode = debug,develop
    xdebug.start_with_request = yes
    xdebug.client_port = 9003
    xdebug.max_nesting_level = 512
  '';
}
