{
  mgr = {
    prepend_keymap = [
      # gf：跳到常用的 Flakes 仓库
      {
        on = [
          "g"
          "f"
        ];
        run = "cd ~/Flakes";
      }
      # ydv：直接调用 yt-dlp 下载视频
      {
        on = [
          "y"
          "d"
          "v"
        ];
        run = "shell --interactive --orphan 'yt-dlp -ic '";
      }
      # yy：显式描述复制行为，方便 README 中引用
      {
        on = [
          "y"
          "y"
        ];
        run = "yank";
        desc = "Yank selected files (copy)";
      }
      # yda：yt-dlp 下载音频并转 MP3
      {
        on = [
          "y"
          "d"
          "a"
        ];
        run = "shell --interactive --orphan 'yt-dlp -x --audio-format mp3 '";
      }
    ];
  };
}
