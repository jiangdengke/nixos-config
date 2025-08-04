{ config, pkgs, ... }:

{
  programs.yazi.keymap = {
    # 管理器模式下的键位绑定
    manager = {
      # 基础移动
      j = "move_cursor down";
      k = "move_cursor up";
      h = "leave";
      l = "enter";
      
      # 光标移动
      J = [ "move_cursor 5 down" ];
      K = [ "move_cursor 5 up" ];
      
      # 视图滚动
      "<C-d>" = [ "move_cursor half_page_down" ];
      "<C-u>" = [ "move_cursor half_page_up" ];
      "<C-f>" = [ "move_cursor page_down" ];
      "<C-b>" = [ "move_cursor page_up" ];
      
      # 页面导航
      g = { g = "move_cursor home" };
      G = [ "move_cursor end" ];
      
      # 标签页管理
      t = "tab_create";
      w = "tab_close";
      "<Tab>" = "tab_next";
      "<S-Tab>" = "tab_prev";
      
      # 文件操作
      y = "copy_filepath";
      Y = "copy_filename";
      
      p = "paste";
      P = "paste --force";
      
      d = "cut";
      D = "remove --permanently";
      
      a = "create";
      r = "rename";
      
      # 文件选择
      space = "select";
      v = "visual_mode";
      V = "visual_mode --unset";
      "<C-a>" = "select_all";
      "<C-r>" = "select_all --unset";
      
      # 其他操作
      "." = "toggle_hidden";
      "/" = "search";
      "?" = "search --previous";
      n = "search_next";
      N = "search_prev";
      
      # 自定义命令
      ":" = "command";
      ";" = "shell";
      
      # 退出
      q = "quit";
    };
    
    # 视觉模式下的键位绑定
    visual = {
      j = "move_cursor down";
      k = "move_cursor up";
      
      # 选择操作
      y = "copy";
      d = "cut";
      p = "paste";
      P = "paste --force";
      
      # 退出视觉模式
      escape = "visual_mode --unset";
    };
    
    # 预览模式下的键位绑定
    preview = {
      j = "preview_scroll down";
      k = "preview_scroll up";
      
      J = [ "preview_scroll 5 down" ];
      K = [ "preview_scroll 5 up" ];
      
      "<C-d>" = [ "preview_scroll half_page_down" ];
      "<C-u>" = [ "preview_scroll half_page_up" ];
      "<C-f>" = [ "preview_scroll page_down" ];
      "<C-b>" = [ "preview_scroll page_up" ];
      
      g = { g = "preview_scroll top" };
      G = [ "preview_scroll bottom" ];
    };
    
    # 输入模式下的键位绑定
    input = {
      "<C-p>" = "history_complete --next";
      "<C-n>" = "history_complete --prev";
      "<Up>" = "history_complete --next";
      "<Down>" = "history_complete --prev";
      "<C-c>" = "escape";
    };
  };
}
