#!/usr/bin/env bash

source "./lib/config.sh"
# gets the dir in which the script was called
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATEDIR="${BASEDIR}/${TEMPLATEDIR}"
LOGSDIR="${BASEDIR}/${LOGSDIR}"

# as soon as a command returns != 0 exits
set -e

load_libs() {
	local libs=(
		colors
		interaction
		utils
		git
		homebrew
		jvm
	)

	# while accessign arrays we need to use curly braces to prevent
	# interpretation and reference all the values with the @ index
	for lib in ${libs[@]}; do
		source "$BASEDIR/lib/${lib}.sh"
	done
}

load_libs

log_config() {
	header "Installing using config"
	info:sm "Installing onto:         ${bold}${purple}${HOMEDIR}${reset}"
	info:sm "Using dotfiles from:     ${bold}${purple}${BASEDIR}${reset}"
	info:sm "Using templates from:    ${bold}${purple}${TEMPLATEDIR}${reset}"
	info:sm "Writing logs to:         ${bold}${purple}${LOGSDIR}${reset}"
	info:sm "Backup will be done in:  ${bold}${purple}${BACKUPDIR}${reset}"
	separator
}

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
	local overwrite_all=false
	local backup_all=false
	local skip_all=false

	for file in ${dotfiles[@]}; do
		link_file "${BASEDIR}/${file}" "${HOMEDIR}/${file}"
	done

	success "The dotfiles were linked"
}

init () {
	header "${reset}${bold}Installing ${blue}.dotfiles${reset}"
	prompt_continue
	log_config
	link_dotfiles
	install_git
	install_homebrew
	install_sdkman
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
