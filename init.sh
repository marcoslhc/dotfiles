#!/usr/bin/env bash

# gets the dir in which the script was called
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# as soon as a command returns != 0 exits
set -e

load_libs() {
	local libs=(
		config
		colors
		interaction
		utils
		git
		homebrew
	)

	# while accessign arrays we need to use curly braces to prevent
	# interpretation and reference all the values with the @ index
	for lib in ${libs[@]}; do
		source "$BASEDIR/lib/${lib}.sh"
	done
}

load_libs

if ! [[ -d $LOGSDIR ]]; then
	mkdir -p $LOGSDIR;
	success:sm "Log directory created at ${reset}${bold}${purple}${LOGSDIR}${reset}"
else
	info:sm "Writing logs to ${reset}${bold}${purple}${LOGSDIR}${reset}"
fi

link_dotfiles() {
	local dotfiles=(
		.aliases
		.bash_profile
		.bash_prompt
		.bashrc
		.curlrc
		.editorconfig
		.exports
		.functions
		.gdbinit
		.gvimrc
		.hgignore
		.hushlogin
		.inputrc
		.macos
		.osx
		.path
		.screenrc
		.tmux.conf
		.vimrc
		.wgetrc
		tmux.sh
	)
}
init () {
	header "${reset}${bold}Installing ${blue}.dotfiles${reset}"
	prompt_continue
	configure_git
	install_homebrew
}

# Warns the user about the task and asks for permission
prompt_continue() {
	warning "You are about to do something undoable"                                         # Warning about dangerous task
	indent "This is a serious and dangerous task"
	indent "That could result in unrecoverable loss of data"

	prompt "${reset}Continue ${bold}${green} (Y)es ${reset} / ${bold}${red} (N)o ${reset}: "

	read_input response

	case $response in
		[Yy] )
			success "Continue";;
		[Nn] )
			info "Stop all Activity"; exit 0;;
		* )
			error "Option not available"; exit 1;;
	esac

	return 0
}

init
