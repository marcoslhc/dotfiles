#!/usr/bin/env bash

install_homebrew () {
	header "${reset} Installing ${bold}${yellow}Homebrew${reset}"
	if test ! $(which brew); then
		if is_macos; then
			ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > $LOGSDIR/homebrew.log
			success "${reset}Homebrew Installed"
		elif is_linux; then
			ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)" > $LOGSDIR/Linuxbrew.log
			success "${reset}Linuxebrew Installed"
		else
			error "OS not compatible with Brew"
		fi
	else
		info "Already installed"
	fi

	update_homebrew
	install_brewfile
}

update_homebrew () {
	if test $(which brew); then
		header "${reset} Updating ${bold}${yellow}Homebrew${reset}"
		info "Check the output logs in ${bold}${purple}$LOGSDIR/Homebrew.log"
		info "Upgrade"
		brew upgrade >> $LOGSDIR/Homebrew.log
		info "Update"
		brew update >> $LOGSDIR/Homebrew.log
		info "Cleanup"
		brew cleanup >> $LOGSDIR/Homebrew.log
		success "Brew updated correctly"
	fi
}

install_brewfile () {
	if test $(which brew); then
		header "${reset} Installing ${bold}${yellow}Brew Bundle${reset}"

		info "Installing applications in ${reset}${bold}${purple}/Applications${reset}"
		info "Check the logs in ${bold}${purple}$LOGSDIR/brewbundle.log"
		brew bundle install > $LOGSDIR/brewbundle.log
		success "Brew Bundles installed"
	fi
}
