#!/usr/bin/env bash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"
msg(){
	case "$1" in
		error)
			printf '%s\n' "${RED}[ERROR]:${RESET} $2"
			;;
		success)
			printf '%s\n' "${GREEN}[SUCCESS]:${RESET} $2"
			;;
		debug)
			printf '%s\n' "${BLUE}[DEBUG]:${RESET} $2"
			;;
	esac
}

if [ ! -d "$HOME/.config/niri" ]; then
	stow -t ~/.config/niri niri
else
	msg error "Directory niri doesn't exist."
	read -r -p "Make directory? (y/n) " dir_make
	select dir_make in "y" "n";do
		if [ "$dir_make" == "y" ];then
			mkdir "$HOME/.config/niri"
			stow -t ~/.config/niri niri
			msg success "Created directory niri and stowed files"
		fi
	done
fi

select qs_shell in "noctalia" "dms (Dank Material Shell)"
do
	if [ "$qs_shell" == "noctalia" ]; then
		systemctl --user add-wants niri.service noctalia.service
		systemctl --user enable noctalia.service
		break
	else
		systemctl --user enable dms
		systemctl --user start dms
		break
	fi
done
