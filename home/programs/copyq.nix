{ config, pkgs, lib, ... }:

{
  # 启用Home Manager的CopyQ服务
  services.copyq = {
    enable = true;
    package = pkgs.copyq;
    systemdTarget = "graphical-session.target";
  };

  # 为i3添加CopyQ配置
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # 添加mod+v快捷键来调出菜单
      keybindings = lib.mkOptionDefault {
        # 使用鼠标位置显示菜单命令
        "${config.xsession.windowManager.i3.config.modifier}+v" = "exec ${pkgs.copyq}/bin/copyq 'execute(\"鼠标位置剪贴板菜单\")'";
      };
    };
  };

  # CopyQ的配置文件
  xdg.configFile = {
    "copyq/copyq.conf" = {
      text = ''
        [General]
        plugin_priority=itemimage, itemtext
        
        [Options]
        action_has_input=false
        action_has_output=false
        action_separator=\\n
        activate_closes=true
        activate_focuses=true
        activate_pastes=true
        always_on_top=true
        autostart=true
        check_clipboard=true
        check_selection=false
        clipboard_notification_lines=0
        clipboard_tab=&clipboard
        close_on_unfocus=true
        command_history_size=100
        confirm_exit=true
        copy_clipboard=true
        copy_selection=false
        disable_tray=false
        edit_ctrl_return=true
        editor=gedit --standalone -- %1
        expire_tab=0
        hide_main_window=true
        hide_tabs=false
        hide_toolbar=false
        hide_toolbar_labels=true
        item_popup_interval=0
        language=en
        max_process_manager_rows=1000
        maxitems=200
        move=true
        native_menu_bar=true
        notification_horizontal_offset=10
        notification_maximum_height=100
        notification_maximum_width=300
        notification_position=2
        notification_vertical_offset=10
        number_search=true
        row_index_from_one=true
        run_selection=true
        save_delay_ms_on_item_added=300000
        save_delay_ms_on_item_edited=1000
        save_delay_ms_on_item_modified=300000
        save_delay_ms_on_item_moved=1800000
        save_delay_ms_on_item_removed=600000
        save_filter_history=false
        save_on_app_deactivated=true
        script_paste_delay_ms=250
        show_advanced_command_settings=false
        show_simple_items=true
        show_tab_item_count=false
        tab_tree=false
        tabs=&clipboard
        text_tab_width=8
        text_wrap=true
        transparency=0
        transparency_focused=0
        tray_items=5
        tray_menu_open_on_left_click=false
        tray_tab=
        tray_tab_is_current=true
        use_system_tray=true
        vi=false
      '';
      force = true;  # 强制覆盖现有文件
    };
    
    # 修复后的命令配置
    "copyq/copyq-commands.ini" = {
      text = ''
        [Commands]
        1\Name=鼠标位置剪贴板菜单
        1\Command=copyq:\n    // 在鼠标位置显示剪贴板菜单\n    var menuItems = [];\n    var clipboardData = tab("clipboard");\n    \n    // 只获取前15条历史记录\n    var count = Math.min(clipboardData.length, 15);\n    \n    for (var i = 0; i < count; ++i) {\n        var text = str(clipboardData[i]);\n        // 限制文本长度以避免菜单过长\n        var shortText = text.length > 50 ? text.substring(0, 47) + "..." : text;\n        // 去除多行文本中的换行符\n        shortText = shortText.replace(/\\n/g, " ");\n        menuItems.push( { text: (i+1) + ". " + shortText, row: i } );\n    }\n    \n    // 获取鼠标位置并显示菜单\n    var screenGeometry = screenGeometry();\n    var x = screenGeometry.x + screenGeometry.width / 2;\n    var y = screenGeometry.y + screenGeometry.height / 2;\n    \n    // 尝试获取更精确的鼠标位置\n    if (typeof cursorPosition === "function") {\n        var pos = cursorPosition();\n        if (pos) {\n            x = pos.x;\n            y = pos.y;\n        }\n    }\n    \n    var itemIndex = menu(menuItems, x, y);\n    if (itemIndex !== -1) {\n        var row = menuItems[itemIndex].row;\n        select(row);\n        copy(row);\n        paste();\n    }
        1\Icon=\xf245
        1\IsGlobalShortcut=false
        1\Enable=true
        
        2\Name=鼠标位置搜索菜单
        2\Command=copyq:\n    // 在鼠标位置显示带搜索的菜单\n    var clipboardData = tab("clipboard");\n    var count = Math.min(clipboardData.length, 30);\n    \n    // 获取鼠标位置\n    var screenGeometry = screenGeometry();\n    var x = screenGeometry.x + screenGeometry.width / 2;\n    var y = screenGeometry.y + screenGeometry.height / 2;\n    \n    // 尝试获取更精确的鼠标位置\n    if (typeof cursorPosition === "function") {\n        var pos = cursorPosition();\n        if (pos) {\n            x = pos.x;\n            y = pos.y;\n        }\n    }\n    \n    // 显示搜索对话框\n    var searchText = dialog(\n        ".title", "搜索剪贴板",\n        ".x", x,\n        ".y", y,\n        ".width", 300,\n        ".height", 60,\n        ".icon", "edit-find",\n        "搜索:", "");\n    \n    if (searchText === null)\n        return;\n    \n    // 过滤项目并创建菜单\n    var menuItems = [];\n    var searchLower = searchText.toLowerCase();\n    var itemCounter = 0;\n    \n    for (var i = 0; i < count; ++i) {\n        var text = str(clipboardData[i]);\n        var textLower = text.toLowerCase();\n        \n        if (searchText === "" || textLower.indexOf(searchLower) !== -1) {\n            var shortText = text.length > 60 ? text.substring(0, 57) + "..." : text;\n            shortText = shortText.replace(/\\n/g, " ");\n            itemCounter++;\n            menuItems.push({ text: itemCounter + ". " + shortText, row: i });\n            \n            if (itemCounter >= 20)\n                break;\n        }\n    }\n    \n    if (menuItems.length === 0) {\n        popup("未找到匹配项", "搜索结果");\n        return;\n    }\n    \n    var itemIndex = menu(menuItems, x, y);\n    if (itemIndex !== -1) {\n        var row = menuItems[itemIndex].row;\n        select(row);\n        copy(row);\n        paste();\n    }
        2\Icon=\xf002
        2\IsGlobalShortcut=false
        2\Enable=true
        
        3\Name=数字键快捷选择
        3\Command=copyq:\n    // 允许使用数字键快速选择\n    var key = str(data(mimeText));\n    var index = parseInt(key) - 1;\n    if (!isNaN(index) && index >= 0 && index < tab("clipboard").length) {\n        select(index);\n        copy(index);\n        paste();\n    }
        3\Input=text/plain
        3\IsGlobalShortcut=false
        3\Enable=true
        
        size=3
      '';
      force = true;  # 强制覆盖现有文件
    };
  };
}
