#!/usr/bin/env bash

# prints a line
separator () {
	echo "--------------------------------------------------------------------------------"
}

header () {
	local message="$1"
	separator
	echo "${message}"
	separator
}

# prints a formatted message for warning the user
# usage
# warning "message"
warning () {
	local message="$1"
	echo "${reset}[ ${bold}${yellow}WARNING${reset} ] ${message}"
}

# prints a formatted message for informing the user about a task that succeded
# usage
# success "message"
success () {
	local message="$1"
	echo "${reset}[ ${bold}${green}SUCCESS${reset} ] ${message}"
}

# prints a formatted message for informing the user about a failed task
# usage
# success "message"
error () {
	local message="$1"
	echo "${reset}[ ${bold}${red} ERROR ${reset} ] ${message}"
}

# prints a formatted message to give the user general information
# usage
# success "message"
info () {
	local message="$1"
	echo "${reset}[ ${bold}${blue}  INFO ${reset} ] ${message}"
}
# prints a formatted message for warning the user
# usage
# warning "message"
warning:sm () {
	local message="$1"
	echo -e "${reset}${bold}${yellow}\xE2\x9A\x91${reset}${bold}${reset}  ${message}"
}

# prints a formatted message for informing the user about a task that succeded
# usage
# success "message"
success:sm () {
	local message="$1"
	echo -e "${reset}${bold}${green}\xE2\x9C\x94${reset}${bold}${reset}  ${message}"
}

# prints a formatted message for informing the user about a failed task
# usage
# success "message"
error:sm () {
	local message="$1"
	echo -e "${reset}${bold}${red}\xe2\x9c\x98${reset}${bold}${reset}  ${message}"
}

# prints a formatted message to give the user general information
# usage
# success "message"
info:sm () {
	local message="$1"
	echo -e "${reset}${bold}${blue}\xe2\x9A\x91${reset}${bold}${reset}  ${message}"
}

prompt () {
	local message="$1"
	echo "${reset}          ${bold}${blue}?${reset} ${message}"
}

indent () {
	local message="$1"
	echo "${reset}            $1"
}

read_input () {
	local input=$1
	echo -n "${reset}${bold}${blue}        ==>${reset} "
	read -e in
	eval $input="'$in'"
}


