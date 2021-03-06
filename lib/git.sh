#!/usr/bin/env bash

configure_git () {
	local git_credential="cache"

	if is_macos; then
		git_credential="osxkeychain"
	fi


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

	for file in "${linked_dotfiles[@]}"; do
		link_file "${BASEDIR}/${file}" "${HOMEDIR}/${file}" -r
	done

	success:sm "Git dotfiles linked successfully"

	for file in "${generated_dotfiles[@]}"; do
		mv "${TEMPLATEDIR}/${file}" "${HOMEDIR}/${file//.results/}"
	done

	success:sm "Git config file moved successfully"
}

install_git() {
	header "Configuring ${reset}${bold}${yellow}Git${reset}"
	info "Generating gitconfig"
	configure_git
	info "Linking and copying git dotfiles"
	copy_files_git
	success "Git configured successfully"
}
