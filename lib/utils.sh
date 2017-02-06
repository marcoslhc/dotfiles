#!/usr/bin/env bash

render_template() {
	local template="${@: -2: 1}"                # get the parameter before last
				#         |  |___________________ 1 parameter
				#         |______________________ In the second position counting
				#                                 from the tail

	local dest="${@: -1}"                       # get the last parameter
			#         |__________________________ 1 parameter in the first position
			#                                     from the tail

	local context=()                            # initialize context

	# create context
	# context variables comes in the form VARIABLENAME=value

	for subst in "${@}";do
		if [[ "${subst}" =~ ^.*=.*$ ]]; then
			IFS='=' read -a ctxvar <<< $subst; tplstr="${ctxvar[0]}"; valstr="${ctxvar[1]}"
			context+=('-e '"s/\{\{${tplstr}\}\}/$valstr/g")
			info:sm "Setting ${tplstr} to ${valstr}"
		fi
	done

	#execute the substitutions
	sed -E "${context[@]}" $template > $dest
}

is_macos () { if [ "$(uname -s)" == "Darwin" ]; then return 0; else return 1; fi }

is_linux () { if test "$(expr substr $(uname -s) 1 5)" = "Linux"; then return 0; else return 1; fi }

link_file() {
	local success_message="Successfully linked ${reset}${bold}${purple}${2}${reset} to ${reset}${bold}${purple}${1}${reset}"
	local srcfile=$1
	local dstfile=$2

	ln -s "${srcfile}" "${dstfile}"
	success:sm "${success_message}"
}
