{ config, pkgs, lib, ... }:

{
  # 启用 fcitx5 输入法
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      # 安装中文输入法引擎
      fcitx5-rime              # Rime 输入法 (推荐)
      fcitx5-chinese-addons    # 中文输入法 (包含拼音和五笔)
      
      # 可选插件
      fcitx5-gtk               # GTK 前端支持
      fcitx5-configtool        # 配置工具
      fcitx5-material-color    # 主题
    ];
  };
  
  # 配置环境变量确保应用程序能识别 fcitx5
  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus"; # GLFW 应用（如 Minecraft）
  };
  
  # 配置 fcitx5 使用 rime (若您使用拼音，可以跳过此部分)
  xdg.configFile = {
    # 基本配置
    "fcitx5/profile" = {
      text = ''
        [Groups/0]
        # 输入法列表
        Name=默认
        Default Layout=us
        DefaultIM=rime

        [Groups/0/Items/0]
        # 英文输入法
        Name=keyboard-us
        Layout=

        [Groups/0/Items/1]
        # 中文输入法
        Name=rime
        Layout=

        [GroupOrder]
        0=默认
      '';
    };
    
    # 配置 rime 输入法（若使用拼音输入法可以跳过）
    "fcitx5/conf/rime.conf" = {
      text = ''
        # 在此处可以调整 rime 输入法配置
        # 请根据您的偏好调整
      '';
    };
    
    # 配置中文拼音输入法（若使用 rime 可以跳过）
    "fcitx5/conf/pinyin.conf" = {
      text = ''
        # 拼音配置
        PageSize=9
        CloudPinyinEnabled=True
        CloudPinyinIndex=2
        PreeditInApplication=True
        ShowPreeditInApplication=True
        ShuangpinProfile=Ziranma
        
        # 在此处可以添加更多拼音配置...
      '';
    };
    
    # 全局配置
    "fcitx5/config" = {
      text = ''
        [Behavior]
        # 切换输入法快捷键
        # 可选项: Alt, Control, Shift
        SwitchInputMethodKey=Alt_Shift

        [Hotkey]
        # 可用输入法切换
        EnumerateWithTriggerKeys=True
        # 输入法切换快捷键
        TriggerKeys=
        # 激活输入法
        ActivateKeys=
        # 取消激活输入法
        DeactivateKeys=
        
        # 在此处可以添加更多配置...
      '';
    };
    
    # UI 配置
    "fcitx5/conf/classicui.conf" = {
      text = ''
        # 垂直候选列表
        Vertical Candidate List=False
        
        # 按每页固定的候选词个数分页
        PerScreenPagination=True
        
        # 使用鼠标滚轮切换页
        WheelForPaging=True
        
        # 字体
        Font="思源黑体 CN Medium 12"
        
        # 菜单字体
        MenuFont="思源黑体 CN Medium 12"
        
        # 托盘字体
        TrayFont="思源黑体 CN Bold 12"
        
        # 托盘标签轮廓颜色
        TrayOutlineColor=#000000
        
        # 托盘标签文本颜色
        TrayTextColor=#ffffff
        
        # 优先使用文字图标
        PreferTextIcon=False
        
        # 使用输入法的语言来显示文字图标
        UseInputMethodLanguageToDisplayText=True
        
        # 主题
        Theme=Material-Color-DeepPurple
        
        # 深色主题
        DarkTheme=default-dark
        
        # 跟随系统深色主题设置
        UseDarkTheme=False
        
        # 在 X11 上针对不支持 DBus 的特定应用设置主题
        ClassicUISettings=False
      '';
    };
  };
  
  # 确保安装中文字体
  home.packages = with pkgs; [
    # 中文字体
    noto-fonts-cjk
    source-han-sans  # 思源黑体
    source-han-serif # 思源宋体
    
    # 如果您想要安装 Fcitx5 的图形配置工具
    fcitx5-configtool
    
    # 在 i3wm 环境下自动启动 fcitx5
    libsForQt5.fcitx5-qt
    fcitx5-gtk
  ];
  
  # i3wm 中自动启动 fcitx5
  # 如果您使用 i3wm，可以添加以下配置
  xsession.windowManager.i3 = lib.mkIf (config.xsession.windowManager.i3.enable or false) {
    config = {
      startup = [
        {
          command = "fcitx5 -d";
          always = false;
          notification = false;
        }
      ];
    };
  };
}
