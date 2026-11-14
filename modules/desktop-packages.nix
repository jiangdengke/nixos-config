# 锁定 nixpkgs 的 QQ / Chrome 旧源已下架，仅覆盖这两个桌面包。
# 版本与哈希取自 NixOS/nixpkgs 的 qq/sources.nix、google-chrome/package.nix。
# QQ 使用上游同款官方签名接口；临时 URL 不入库，下载结果仍校验固定哈希。
{ lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      google-chrome = prev.google-chrome.overrideAttrs (_old: {
        version = "157.0.8103.50";
        src = final.fetchurl {
          url = "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_157.0.8103.50-1_amd64.deb";
          hash = "sha256-khSL0U3AWCOmQGHC+vzyDU2Cs/xW9YMSBvFtKsnuP3k=";
        };
      });

      qq = prev.qq.overrideAttrs (old: {
        version = "3.2.34-2026-09-24";
        src = final.runCommandLocal "QQ_3.2.34_260924_amd64_01.deb" {
          nativeBuildInputs = [ (lib.getBin final.curl) (lib.getBin final.jq) ];
          SSL_CERT_FILE = "${final.cacert}/etc/ssl/certs/ca-bundle.crt";
          impureEnvVars = lib.fetchers.proxyImpureEnvVars;
          outputHashAlgo = "sha256";
          outputHashMode = "flat";
          outputHash = "sha256-Q2xl4d0oQi4SiiHL3bX+Ti5sB51/J/7CVB4BTTjMM24=";
        } ''
          signedUrl=$(curl -fsS --retry 3 --retry-all-errors --connect-timeout 20 \
            -X POST 'https://im.qq.com/http2rpc/gotrpc/noauth/trpc.qqntv2.urlsign.UrlSign/GetSign' \
            -H 'Content-Type: application/json' \
            -H 'x-oidb: {"uint32_command":"0x9b8e","uint32_service_type":1}' \
            -d '{"url":"https://qqdl.gtimg.cn/qqfile/QQNTV2/9.9.36/release/9ee04bef/QQ_3.2.34_260924_amd64_01.deb"}' \
            | jq -er '.data.url')
          curl -fsSL --retry 3 --retry-all-errors --connect-timeout 20 -o "$out" "$signedUrl"
        '';
        # 新版本不再捆绑 sharp-lib；其余打包与库修补沿用锁定 nixpkgs。
        installPhase = lib.replaceStrings
          [ "rm -r $out/opt/QQ/resources/app/sharp-lib" ]
          [ "rm -rf $out/opt/QQ/resources/app/sharp-lib" ]
          old.installPhase;
      });
    })
  ];
}
