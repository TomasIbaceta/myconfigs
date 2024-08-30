#!/bin/bash

# Define the absolute path
WORKPATH="/mnt/c/GitHub/01.Electrolisis/Sensor/Sensor-Piloto/SW/Core"

# Create a new tmux session named "ElectrolisisSensor"
tmux new-session -d -s ElectrolisisSensor -c "$WORKPATH"

# Split the window into two panes (top and bottom), both set to the correct directory
tmux split-window -v -c "$WORKPATH"

# Resize the top pane
tmux resize-pane -D 30  # Adjust the number to achieve the desired split (e.g., 20 lines moved down)

# Open Neovim in the top pane
tmux send-keys -t 0 "cd $WORKPATH" C-m
tmux send-keys -t 0 "nvim" C-m

# Ensure the bottom pane is in the correct directory
tmux send-keys -t 1 "cd $WORKPATH" C-m
tmux send-keys -t 1 "" C-m

# Create an extra window with only one pane, set to the correct directory
tmux new-window -c "$WORKPATH" -t ElectrolisisSensor

# Go back to the first window (where Neovim is running)
tmux select-window -t ElectrolisisSensor:0

# Attach to the tmux session
tmux attach-session -t ElectrolisisSensor

