#!/bin/bash

# Define the directories
dir2="$HOME/.config/waybar/scripts"

# Function to chmod scripts in a directory
chmod_scripts() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Changing permissions for scripts in $dir"
        find "$dir" -type f -iname "*.sh" -exec chmod +x {} \;
        echo "Permissions changed successfully."
    else
        echo "Directory $dir does not exist."
    fi
}

# Create symlinks and run baraction.sh
create_symlinks_and_run_baraction() {
    # Define the paths for the desktop and laptop configurations
    DESKTOP_CONFIG_PATH=~/.config/waybar/conf/w1-config-desktop.jsonc
    LAPTOP_CONFIG_PATH=~/.config/waybar/conf/w2-config-laptop.jsonc

    # Define the paths for the desktop and laptop styles
    DESKTOP_STYLE_PATH=~/.config/waybar/style/w1-style.css
    LAPTOP_STYLE_PATH=~/.config/waybar/style/w2-style.css

    # Check the current Waybar configuration path
    CURRENT_CONFIG=$(readlink -f ~/.config/waybar/config.jsonc)

    # Check if the flag file exists
    FLAG_FILE="$HOME/.config/waybar/scripts/execution_flag"

    if [ ! -e "$FLAG_FILE" ]; then
        # Run scripts for the first time
        
        echo "Running scripts for the first time..."
        
        # Run chmod_scripts for directory with baraction.sh
        chmod_scripts "$dir2"
        
        # Check the current configuration and switch to the opposite
        if [ "$CURRENT_CONFIG" = "$DESKTOP_CONFIG_PATH" ]; then
            ln -sf "$LAPTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
            ln -sf "$LAPTOP_STYLE_PATH" ~/.config/waybar/style.css
        else
            ln -sf "$DESKTOP_CONFIG_PATH" ~/.config/waybar/config.jsonc
            ln -sf "$DESKTOP_STYLE_PATH" ~/.config/waybar/style.css
        fi
        
        # Create the flag file to prevent future runs
        touch "$FLAG_FILE"
    else
        echo "Scripts have already been executed. Exiting."
    fi
}

# Run the function to create symlinks and run baraction.sh
create_symlinks_and_run_baraction

# kill Waybar
pkill waybar
