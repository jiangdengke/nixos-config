{ config, pkgs, ... }:

{
  programs.yazi.theme = {
    # 颜色配置
    color = {
      # 主要元素颜色
      foreground = { active = "#E4E4E4"; inactive = "#BBBBBB"; };
      background = { active = "#282C34"; inactive = "#1E222A"; };
      selection = { active = "#393F4A"; inactive = "#2C313C"; };
      
      # 界面元素颜色
      directory = { active = "#61AFEF"; inactive = "#528BFF"; };
      regular = "#ABB2BF";
      executable = "#98C379";
      symlink = "#E5C07B";
      broken = "#E06C75";
      
      # 特殊文件类型颜色
      image = "#C678DD";
      video = "#D19A66";
      audio = "#56B6C2";
      archive = "#D19A66";
      document = "#56B6C2";
      
      # 状态栏和标签栏颜色
      tab = { active = "#61AFEF"; inactive = "#ABB2BF"; };
      status = { 
        primary = "#61AFEF";
        secondary = "#98C379"; 
        tertiary = "#E5C07B";
      };
      border = { active = "#61AFEF"; inactive = "#528BFF"; preview = "#98C379"; };
      
      # 预览区域颜色
      preview = { 
        directory = "#61AFEF";
        regular = "#ABB2BF"; 
      };
      
      # 高亮颜色
      hovered = {
        fg = "#FFFFFF";
        bg = "#3E4452";
      };
      
      # 修改状态颜色
      copied = { fg = "#98C379"; bg = "#3E4452"; };
      cut = { fg = "#E06C75"; bg = "#3E4452"; };
      
      # 命令行颜色
      command = {
        fg = "#E4E4E4";
        bg = "#282C34";
      };
      
      # 错误信息颜色
      error = {
        fg = "#E06C75";
        bg = "#282C34";
      };
      
      # 警告信息颜色
      warning = {
        fg = "#E5C07B";
        bg = "#282C34";
      };
      
      # 信息提示颜色
      info = {
        fg = "#61AFEF";
        bg = "#282C34";
      };
    };
    
    # 预览语法高亮主题
    syntax = {
      comment = "#5C6370";
      constant = "#D19A66";
      string = "#98C379";
      character = "#98C379";
      number = "#D19A66";
      boolean = "#D19A66";
      float = "#D19A66";
      identifier = "#E06C75";
      function = "#61AFEF";
      statement = "#C678DD";
      conditional = "#C678DD";
      repeat = "#C678DD";
      label = "#E5C07B";
      operator = "#56B6C2";
      keyword = "#C678DD";
      exception = "#C678DD";
      preproc = "#E5C07B";
      type = "#E5C07B";
      structure = "#E5C07B";
      typedef = "#E5C07B";
      namespace = "#E06C75";
      preprocessor = "#E5C07B";
      special = "#56B6C2";
      error = "#E06C75";
      todo = "#E5C07B";
      variable = "#ABB2BF";
    };
  };
}
