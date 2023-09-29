# See LICENSE file for copyright and license details.
SHELL := /bin/bash
user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)

install: basePackages suckless alias nvim-wincent
	chown -R $(user):$(user) $(user_home)/
	echo "Success" > install
	echo "Now reboot to complete the installation"

basePackages:
	apt-get install nala -y
	nala install curl unzip firefox-esr feh picom xclip wireplumber light -y
	echo "Success" > basePackages

addisionalPackages:
	nala install snapd timeshift ninja-build gettext cmake x11-utils x11-xserver-utils \
		python3-full gimp zathura npm pip nodejs cargo ripgrep neofetch-y
	mkdir -p $(user_home)/.local/share/applications
	cp -i configFiles/defaults.list $(user_home)/.local/share/applications/defaults.list
	snap install bitwarden
	# adduser $(user) libvirt
	echo "Success" > addisionalPackages

suckless: startup fonts
	nala install build-essential libx11-dev libxft-dev libxinerama-dev xorg -y
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	echo "Success" > suckless
	
startup:
	cp -i configFiles/.bash_profile $(user_home)/.bash_profile
	cp -i configFiles/.xinitrc $(user_home)/.xinitrc
	mkdir -p $(user_home)/.dwm/
	cp -i configFiles/autostart.sh $(user_home)/.dwm/autostart.sh
	cp -i -r slstatus-scripts/ /
	echo "Success" > startup

alias:
	printf "%s\n" "alias sudo='sudo '" >> $(user_home)/.bashrc
	printf "%s\n" "alias apt=nala" >> $(user_home)/.bashrc
	printf "%s\n" "alias vim=nvim" >> $(user_home)/.bashrc
	printf "%s\n" "alias ll='ls -lhA'" >> $(user_home)/.bashrc
	printf "%s\n" "alias la='ls -a'" >> $(user_home)/.bashrc
	echo "Success" > alias

fonts:
	mkdir -p $(user_home)/.fonts/FiraCode
	unzip FiraCode.zip -d $(user_home)/.fonts/FiraCode
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

nvim-wincent: nvim
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
		$(user_home)/.local/share/nvim/site/pack/packer/start/packer.nvim
	mkdir -p $(user_home)/.config
	git clone git@github.com:jonwin1/nvim-wincent
	mv nvim-wincent $(user_home)/.config/nvim
	echo "Success" > nvim-wincent

resolveEACCES: # Not done
	nala install -y ca-certificates curl gnupg
	mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo nala update
	sudo nala install nodejs -y
	echo "Success" > resolveEACCES

qemu-kvm:
	nala install qemu-system libvirt-daemon-system virt-manager ovmf -y
	echo "Success" > qemu-kvm

swipl:
	nala install snapd -y
	snap install swi-prolog
	snap alias swi-prolog.swipl swipl
	snap alias swi-prolog.swipl-win swipl-win
	echo "Success" > swipl

valgrind:
	nala install valgrind -y

clean:
	rm -f install basePackages addisionalPackages suckless startup fonts warp nvim swipl lunarvim qemu-kvm
	rm -f /usr/bin/nvim
	rm -rf /squashfs-root
	rm -rf $(user_home)/.local/share/nvim/site/pack/packer/start/packer.nvim
