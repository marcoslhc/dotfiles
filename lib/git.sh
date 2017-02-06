#!/usr/bin/env bash

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

	for file in ${linked_dotfiles[@]}; do
		link_file "${BASEDIR}/${file}" "${BASEDIR}/test/${file}"
	done

}


