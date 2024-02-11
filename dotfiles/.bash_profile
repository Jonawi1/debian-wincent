if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

# Created by `pipx` on 2024-02-11 18:46:37
export PATH="$PATH:/home/jonwin/.local/bin"
