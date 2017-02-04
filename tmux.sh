#!/bin/bash
SESSION=$USER

MAIN_WINDOW_SIZE=$(tput cols)
PROJECTS_DIR="${HOME}/Documents/projects"

if [[ -z $TMUX ]]; then
    tmux -2 new-session -Ad -s $SESSION
    tmux split-window -h -t $SESSION:1.0
    tmux split-window -v -t $SESSION:1.1
    tmux split-window -v -t $SESSION:1.2
    tmux select-layout -t $SESSION:1 main-vertical
    tmux send-keys -t $SESSION:1.0 "cd ${PROJECTS_DIR}" C-m
    tmux send-keys -t $SESSION:1.1 "cd ${PROJECTS_DIR}" C-m
    tmux send-keys -t $SESSION:1.2 "cd ${PROJECTS_DIR}" C-m
    tmux send-keys -t $SESSION:1.3 "cd ${PROJECTS_DIR}" C-m
    tmux attach -t $SESSION
fi
