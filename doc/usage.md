# NAME

gmenu3 - GTK XDG Application Menu

# SYNOPSIS

**gmenu3** \[*--clear-cache | --new-cache*\]

# DESCRIPTION

Display the application menu conforming to the XDG Menu Specification.

<https://specifications.freedesktop.org/menu-spec/latest/>

# OPTIONS

**--clear-cache** clear the cache and exit.

**--new-cache**  
clear the cache then show the menu.

**--version**  
print version and exit.

# ENVIRONMENT

MAIN_MENU_XML:  
*/etc/xdg/menus/applications.menu*

# FILES

User preferences:  
/root/.config/gmenu3.env

Recently-used:  
/root/.config/gmenu3.log

# EXAMPLES

## Keyboard Activation

In addition to invoking gmenu3 from the shell prompt, you may consider
assigning a global hotkey to start the menu. Linux Desktop environments
provide many different ways to do this. Refer to the documentation of
your keyboard manager for instructions. For Fatdog64 look up the Sven
Multimedia Keyboard Manager icon that sits in the panel.

## Click Activation

Here is a sample shell script for X11 systems that invokes gmenu3 when
the user right-clicks on a free area of the root window. The script will
not be able to detect clicks if another application--such as a window
manager like Openbox--is already monitoring the root window.

    #!/bin/sh

    # This script intercepts button-3 (right) clicks on the X11
    # root window, invoking $MENU when the button is released.

    MENU=gmenu3

    pid=$(pgrep -xU $(id -u) "${0##*}")
    if [ -n "$pid" ]; then
    	echo "${0##*/} is already running (pid $pid)"
    	exit
    fi

    trap "pkill -P $$ -x xev" HUP INT ALRM TERM 0

    xev -root -event button -event owner_grab_button |
    grep --line-buffered -A3 "ButtonRelease.*YES" |
    while read EVENT; do
    	case "$EVENT" in
    		*'0,'*'button 3'*) ( $MENU >/dev/null 2>&1 & ) ;;
    	esac
    done &

    wait $!

# AUTHOR

Written by step.

# REPORTING BUGS

Report bugs at <https://github.com/step-/gmenu3/issues>.  
The specification is partially implemented; just enough to fully support
Fatdog64 Linux.

# COPYRIGHT

Copyright © 2025 step <https://github.com/step->.  
This is free software licensed under the GPL2 license.
