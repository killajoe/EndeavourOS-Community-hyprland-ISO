#!/bin/sh
#  ____  _             _    __        __          _                 
# / ___|| |_ __ _ _ __| |_  \ \      / /_ _ _   _| |__   __ _ _ __  
# \___ \| __/ _` | '__| __|  \ \ /\ / / _` | | | | '_ \ / _` | '__| 
#  ___) | || (_| | |  | |_    \ V  V / (_| | |_| | |_) | (_| | |    
# |____/ \__\__,_|_|   \__|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|    
#                                           |___/                   
# by Redblizard (2023) 
# ----------------------------------------------------- 

# ----------------------------------------------------- 
# Quit running waybar instances
# ----------------------------------------------------- 
killall waybar

# ----------------------------------------------------- 
# Loading the configuration based on the username
# ----------------------------------------------------- 
while true; do
    sleep 1s

    # Check if Waybar is already running
    if pgrep -x waybar > /dev/null; then
        echo "[$(date)] Waybar is already running."
        break
    fi

    if [ -e ~/.config/waybar/config.jsonc ]; then
        log_file="/tmp/waybar-$(date +%Y-%m-%d-%H-%M-%S).log"
        echo "[$(date)] Starting Waybar with custom configuration." >> "$log_file"
        waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css &>> "$log_file"
        break  # exit the loop after successfully launching Waybar
    else
        echo "[$(date)] Waybar config not found, using default configuration."        
        waybar &
        break  # exit the loop after launching Waybar with the default configuration
    fi
done

