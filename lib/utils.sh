#!/usr/bin/env bash

render_template() {
	local template="${@: -2: 1}"                # get the parameter before last
				#               |  |___________________ 1 parameter
				#               |______________________ In the second position counting
				#                                       from the tail

	local dest="${@: -1}"                       # get the last parameter
			#             |__________________________ 1 parameter in the first position
			#                                         from the tail

	local context=()                        # initialize context

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
	local resetopts=$3
	local overwrite=
	local skip=
	local backup=
	local same_file=false

	if [[ "${resetopts}" == "-r" ]]; then
		overwrite_all=false;
		backup_all=false;
		skip_all=false;
	fi;

	if [[ -f $dstfile || -d $dstfile || -L $dstfile ]]; then
		if [[ "${overwrite_all}" == "false" || "${backup_all}" == "false"|| "${skip_all}" == "false" ]];then
			if [[ "$(readlink $dstfile)" == "${srcfile}" ]]; then
				skip=true
				same_file=true
			else
				warning "The destination exists, would you like to"
				indent "${reset}${bold}${red}[o/O]verwrite${reset}/${bold}${yellow}[b/B]ackup${reset}/${bold}${blue}[s/S]skip${reset}"
				indent "Use capital letter to apply to the remaining files"
				read_input selection

				case $selection in
					o )
						overwrite=true;;
					O )
						overwrite_all=true;;
					b )
						backup=true;;
					B )
						backup_all=true;;
					s )
						skip=true;;
					S )
						skip_all=true;;
					.* )
						exit 0;;
				esac
			fi
		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [[ "${overwrite}" == "true" ]]; then
			warning "Removing ${dstfile}"
			rm -rf "${dstfile}"
		fi

		if [[ "${backup}" == "true" ]]; then
			if ! [[ -d "${BACKUPDIR}" ]];then
				info:sm "creating backup directory"
				mkdir -p "${BACKUPDIR}"
				success:sm "Created backup directory"
			fi
			mv "${dstfile}" "${BACKUPDIR}/$(basename ${dstfile}).$(date +"%y-%m-%d").backup"
			success:sm "Moved ${dstfile} to ${BACKUPDIR}"
		fi

		if [[ "${skip}" == "true" ]]; then
			if [[ "${same_file}" == "true" ]];then
				info:sm "The source and destination are the same ${dstfile}"
			else
				warning:sm "Skipping file ${dstfile}"
			fi
		fi
	fi

	if [[ "${skip}" != "true" ]];then
		ln -s "${srcfile}" "${dstfile}"
		success:sm "${success_message}"
	fi
}
