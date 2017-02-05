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

is_macos () { if [ "$(uname -s)" == "Darwin" ]; then return 0; else return 1; fi }

is_linux () { if test "$(expr substr $(uname -s) 1 5)" = "Linux"; then return 0; else return 1; fi }

configure_git () {
	local git_credential="cache"

	if is_macos; then
		git_credential="osxkeychain"
	fi

	header "Configuring Git"

	prompt "What is your author name"
	read_input git_authorname

	prompt "Wath is your author email"
	read_input git_authoremail

	render_template \
		"AUTHOR_NAME=${git_authorname}" \
		"AUTHOR_EMAIL=${git_authoremail}" \
		"HELPER=${git_credential}" \
		"${TEMPLATEDIR}/.gitconfig.template" "${TEMPLATEDIR}/.gitconfig.results"

	success:sm "Git Configured"
}

copy_files_git() {
	local linked_dotfiles=(
		.gitattributes
		.gitignore
	)

	local generated_dotfiles=(
		.gitconfig.results
	)


}

link_file() {
	local success_message="Successfully linked ${reset}${bold}${purple}${2}${reset} to ${reset}${bold}${purple}${1}${reset}"
	local srcfile=$1
	local dstfile=$2

	ln -s "${srcfile}" "${dstfile}"
	success:sm "${success_message}"
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

configure_git
#init
