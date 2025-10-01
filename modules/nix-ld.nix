{ config, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    # 按需添加常见运行库，后续缺啥再加啥（先放一套常见组合）
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      glibc
      zlib
      openssl
      curl
      zstd
      xz
      libuuid
      icu
      sqlite
    ];
  };
}
