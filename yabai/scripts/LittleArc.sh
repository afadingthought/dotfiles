#!/bin/bash
# Get the window id from the argument
window_id=$YABAI_WINDOW_ID

# Set the path to the desktop
desktop_path="$HOME/Desktop/debug.txt"
#echo "works" > "$desktop_path"

# Query Yabai for window information
window_info=$(/opt/homebrew/bin/yabai -m query --windows --window "$window_id")
# Extract the app, title, and whether the window is floating
app=$(echo "$window_info" | /opt/homebrew/bin/jq -r '.app')
sublayer=$(echo "$window_info" | /opt/homebrew/bin/jq -r '."sub-layer"')
isfloating=$(echo "$window_info" | /opt/homebrew/bin/jq -r '."is-floating"')

# Check if app is Arc, layer is normal, and window is floating - will leave it floating (yabaiwindow tag)
if [[ "$app" == "Arc" && "$sublayer" == "normal" && "$isfloating" == "true" ]]; then
    # Toggle float on the window. NO LONGER NECESSARY since everything is normal?
    # /opt/homebrew/bin/yabai -m window "$window_id" --sub-layer below
    :
# Check if app is Arc, layer is above, and window is floating - will tile it (yabaitile tag)
elif [[ "$app" == "Arc" && "$sublayer" == "above" && "$isfloating" == "true" ]]; then
    # Create the test.txt file with "hey" as content
    sleep .3
    /opt/homebrew/bin/yabai -m window "$window_id" --toggle float --sub-layer normal
fi
