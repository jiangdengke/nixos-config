# Home Manager 的通用集成设置；具体用户在 hosts/<主机名>/ 中绑定。
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # 文件冲突时报错，不自动覆盖或生成 .backup 文件。
    backupFileExtension = null;
  };
}
