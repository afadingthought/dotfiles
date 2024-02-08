#!/bin/bash

# This script is specifically when little arc is triggered with a key binding... passing an extra variable
# to open as either a float or a tiled window. It's not supposed to replace the functionality of clicking 
# links outside of arc or in arc with modifiers

# Get the window id from the argument
window_id=$YABAI_WINDOW_ID
myaction=$1

# Query Yabai for window information
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window "$window_id")
# Extract the app, title, and whether the window is floating
app=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.app')
layer=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.layer')
is_floating=$(echo "$window_info" | /opt/homebrew/bin/jq -r '."is-floating"')
# Check if app is Arc, layer is normal, and window is floating - will leave it floating (yabaiwindow tag)
if [[ "$app" == "Arc" && "$layer" == "normal" && "$is_floating" == "true" && "$myaction" == "floatcenter" ]]; then
    # Toggle float on the window
    /opt/homebrew/bin/yabai -m window "$window_id" --grid 6:4:1:1:2:4
    /opt/homebrew/bin/yabai -m signal --remove littlearccmd
    /opt/homebrew/bin/yabai -m signal  --add label="littlearc" app='^Arc$' event=window_title_changed action="~/Library/CloudStorage/Dropbox/2-Areas/SystemAndApps/Yabai/LittleArc.sh"
elif [[ "$app" == "Arc" && "$layer" == "normal" && "$is_floating" == "true" && "$myaction" == "tile" ]]; then
   # Toggle float on the window
    /opt/homebrew/bin/yabai -m window "$window_id" --toggle float
    /opt/homebrew/bin/yabai -m signal --remove littlearccmd
    /opt/homebrew/bin/yabai -m signal  --add label="littlearc" app='^Arc$' event=window_title_changed action="~/Library/CloudStorage/Dropbox/2-Areas/SystemAndApps/Yabai/LittleArc.sh"
fi