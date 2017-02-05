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
