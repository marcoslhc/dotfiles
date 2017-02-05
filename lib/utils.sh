#!/usr/bin/env bash
render_template() {
	local template="${@: -2: 1}"                # get the parameter before last
				#         |  |___________________ 1 parameter
				#         |______________________ In the second position counting
				#                                 from the tail

	local dest="${@: -1}"                       # get the last parameter
			#         |__________________________ 1 parameter in the first position
			#                                     from the tail

	local substitutions="${@: 1: ${#}-2}"       # get all the rest
							# |    |  |__________ counting 2 position
							# |    |_____________ from the array length
							# |__________________ take all the elements from the
							#                     first position

	local context=()                            # initialize context

	# create context
	# context variables comes in the form VARIABLENAME=value

	for subst in "${substitutions}";do
		if [[ "${subst}" =~ ^.*=.*$ ]]; then
			IFS='=' read -a ctxvar <<< $subst;  # string splitting, this is cool
			#    |  |        |          |________ we feed the function with the args and
			#    |  |        |___________________ we store in this variable the values
			#    |  |____________________________ we read here
			#    |_______________________________ IFS is the Internal Field Separator
			tplstr="${ctxvar[0]}"; valstr="${ctxvar[1]}"
			context+=('-e '"s/\{\{${tplstr}\}\}/$valstr/g")
		fi
	done

	#execute the substitutions
	sed -E "${context[@]} ${template} > ${dest}"
}
