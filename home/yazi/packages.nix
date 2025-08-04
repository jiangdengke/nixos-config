{ config, pkgs, ... }:

{
  # 安装额外的预览工具
  home.packages = with pkgs; [
    # 基本工具
    file          # 识别文件类型
    bat           # 代码预览高亮
    ripgrep       # 文本搜索
    fd            # 文件查找工具
    fzf           # 模糊查找
    
    # 图像预览
    ueberzug      # X11 下的图像预览
    libsixel      # 终端中的图像显示
    chafa         # 终端图像查看器
    
    # 文档处理
    poppler       # PDF 处理
    poppler_utils # PDF 工具
    ffmpegthumbnailer # 视频缩略图
    
    # 档案和压缩
    unzip
    p7zip
    unrar
    zip
    gnutar
    
    # 文本文件预览
    highlight     # 源代码高亮
    mdcat         # Markdown 查看
    
    # 音频/视频处理
    ffmpeg        # 音视频处理
    
    # 其他可选工具
    jq            # JSON 处理
    mediainfo     # 媒体文件信息
  ];
}
