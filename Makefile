# See LICENSE file for copyright and license details.
SHELL := /bin/bash
user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)

install: basePackages makeInstall startup alias fonts nvim lunarvim
	chown -R $(user):$(user) $(user_home)/
	echo "Success" > install

basePackages:
	apt-get install nala -y
	nala purge nano -y
	nala install build-essential libx11-dev x11-utils x11-xserver-utils \
		libxft-dev libxinerama-dev libxrandr-dev xorg curl unzip \
		python3 python3-venv libvirt-daemon-system qutebrowser feh \
		picom gimp xclip zathura npm pip nodejs cargo ripgrep neofetch -y
	mkdir -p $(user_home)/.local/share/applications
	cp -i configFiles/defaults.list $(user_home)/.local/share/applications/defaults.list
	echo "Success" > basePackages

addisionalPackages:
	nala install snapd timeshift ninja-build gettext cmake ovmf -y
	snap install bitwarden
	# adduser $(user) libvirt
	echo "Success" > addisionalPackages

qemu-kvm:
	nala install qemu-system libvirt-daemon-system virt-manager ovmf -y
	echo "Success" > qemu-kvm

makeInstall:
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	echo "Success" > makeInstall
	
startup:
	cp -i configFiles/.bash_profile $(user_home)/.bash_profile
	cp -i configFiles/.xinitrc $(user_home)/.xinitrc
	mkdir -p $(user_home)/.dwm/
	cp -i configFiles/autostart.sh $(user_home)/.dwm/autostart.sh
	echo "Success" > startup

alias:
	printf "%s\n" "alias sudo='sudo '" >> $(user_home)/.bashrc
	printf "%s\n" "alias apt=nala" >> $(user_home)/.bashrc
	printf "%s\n" "alias vim=nvim" >> $(user_home)/.bashrc
	printf "%s\n" "alias ll='ls -lA'" >> $(user_home)/.bashrc
	printf "%s\n" "alias la='ls -a'" >> $(user_home)/.bashrc
	echo "Success" > alias

fonts:
	mkdir -p $(user_home)/.fonts/FiraCode
	unzip Fira_Code_v6.2.zip -d $(user_home)/.fonts/FiraCode
	echo "Success" > fonts

warp:
	./cloudflareWarp.sh
	echo "Success" > warp

nvim: 
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	mv squashfs-root /
	ln -s /squashfs-root/AppRun /usr/bin/nvim
	echo "Success" > nvim

resolveEACCES: # Not done, DO NOT USE
	nala install -y ca-certificates curl gnupg
	mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo nala update
	sudo nala install nodejs -y
	echo "Success" > resolveEACCES

lunarvim:
	LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

swipl:
	nala install snapd -y
	snap install swi-prolog
	snap alias swi-prolog.swipl swipl
	snap alias swi-prolog.swipl-win swipl-win
	echo "Success" > swipl

clean:
	rm -f install basePackages addisionalPackages makeInstall startup fonts warp nvim swipl lunarvim
	rm -f /usr/bin/nvim
	rm -rf /squashfs-root
