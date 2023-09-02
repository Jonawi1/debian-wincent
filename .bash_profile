if [ -z "${DISPLAY}" ] && [ "${XDG_VNTR}" -eq 1 ]; then
	exec startx
fi
