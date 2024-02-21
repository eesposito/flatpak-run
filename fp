#!/bin/bash

app_name="$1"
display_available_apps="flatpak list --app"

# If no argument provided, show an error message
if [ -z "$app_name" ]; then
    echo "fp: missing operand"
    echo "Try \"fp --help\" for more information."
    exit 1
fi

# Handle special arguments (fp list, fp --help)
case "$app_name" in
    "list")
        echo "Available apps:"
        eval "$display_available_apps"
		exit
        ;;
    
    "--help" | "-h")
		echo "It launches the specified app in Flatpak."
		echo ""
		
		echo "Examples:"
		echo "  'fp vlc' will launch 'org.videolan.VLC'"
		echo "  'fp telegram' will launch 'org.telegram.Desktop'"
		echo "  'fp emacs ~/.bashrc' will launch Emacs editing the file .bashrc"
		echo "  'fp vlc --verbose ~/Videos/some_video.mp4' will launch VLC with some video as argument. Usually it would be launched in the background, the '--verbose' option prevents that."
		echo ""

		echo "Usage:"
		echo "  fp list		shows available apps"
		echo "  fp --help		displays this help and exits"
		echo "  fp -h			same as --help"
		echo ""
		echo "  fp <app_name> [APP_ARGUMENTS]			launches the specified app in the background"
		echo "  fp <app_name> --verbose [APP_ARGUMENTS]	launches the specified app normally"
		echo "  fp <app_name> -v [APP_ARGUMENTS]		same as --verbose"
		echo ""
		
		echo "Available apps:"
		eval "$display_available_apps"
		exit
		;;
esac


# Search for the app
app_id=$(flatpak list --app --columns=application,name | grep -F -i "$app_name" | awk '{print $1}');


# Launch the app if found
# Check if verbose mode is requested
if [ -n "$app_id" ]; then
    if [ "$2" == "-v" ] || [ "$2" == "--verbose" ]; then
		echo "Launching $app_id in the foreground (verbose mode)..."
		shift 2
		flatpak run "$app_id" "$@"
    else
        echo "Launching $app_id in the background..."
		shift
        nohup flatpak run "$app_id" "$@" >/dev/null 2>&1 &
    fi
else
    echo "App not found."
fi
