#!/bin/bash
SESSION=$(echo $USER | sed -e "s/\./-/")

PROJECTS_DIR="${HOME}/Documents/projects"

if [[ -z $TMUX ]]; then
		tmux -2 new-session -Ad -s $SESSION                      # Opens the session with window 1
		tmux split-window -h -t $SESSION:1.0                     # Split the window horizontally
		tmux split-window -v -t $SESSION:1.1                     # Split the upper panel vertically
		tmux split-window -v -t $SESSION:1.2                     # Split the lower panel vertically
		tmux select-layout -t $SESSION:1 main-vertical           # Select special layout with one main panel to the left
		tmux send-keys -t $SESSION:1.0 "cd ${PROJECTS_DIR}" C-m
		tmux send-keys -t $SESSION:1.1 "cd ${PROJECTS_DIR}" C-m
		tmux send-keys -t $SESSION:1.2 "cd ${PROJECTS_DIR}" C-m
		tmux send-keys -t $SESSION:1.3 "cd ${PROJECTS_DIR}" C-m
		tmux attach -t $SESSION                                  # Attach the session
fi
