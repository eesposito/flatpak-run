# flatpak-run

A little bash script to run Flatpak apps from the terminal.

Personally I added it to `~/bin` to always have access to it. The code is very simple, you can check it works as intended in a second.

```
Examples:
  'fp vlc' will launch 'org.videolan.VLC'
  'fp telegram' will launch 'org.telegram.Desktop'
  'fp emacs ~/.bashrc' will launch Emacs editing the file .bashrc
  'fp vlc --verbose ~/Videos/some_video.mp4' will launch VLC with some video as argument. Usually it would be launched in the background, the '--verbose' option prevents that.

Usage:
  fp list               shows available apps
  fp --help             displays this help and exits
  fp -h                 same as --help

  fp <app_name> [APP_ARGUMENTS]                 launches the specified app in the background
  fp <app_name> --verbose [APP_ARGUMENTS]       launches the specified app normally
  fp <app_name> -v [APP_ARGUMENTS]              same as --verbose

```
