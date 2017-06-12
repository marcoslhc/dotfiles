#!/usr/bin/env bash

DOTFILES_ATOMDIR="${BASEDIR}/.atom"
HOME_ATOMDIR="${HOMEDIR}/.atom"


is_atom_installed() { if [[ -a "$(which atom)" ]]; then return 0; else return 1; fi }

install_extensions_from_atomfile() {
	if is_atom_installed; then
		cat Atomfile | cut -d@ -f1 | tr '\n' ' ' | xargs apm install;
	else
		error "Atom is not installed";
		return 0;
	fi;
}

link_atomfiles() {

	if ! is_atom_installed; then
		error "Atom is not installed";
		return 0;
	fi

	local linked_dotfiles=(
		config.cson
		init.coffee
		keymap.cson
		snippets.cson
		styles.less
	)

	local overwrite_all=false
	local backup_all=false
	local skip_all=false

	for file in "$linked_dotfiles[@]"; do
		link_file "${DOTFILES_ATOMDIR}/${file}" "${HOME_ATOMDIR}/${file}"
	done;

	success "The dotfiles were linked"
}
