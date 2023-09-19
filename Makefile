# See LICENSE file for copyright and license details.

user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)

install: basePackages makeInstall startup alias fonts nvim
	chown -R $(user):$(user) $(user_home)/
	echo "Success" > install

basePackages:
	apt-get install nala -y
	nala purge nano -y
	nala install build-essential libx11-dev x11-utils x11-xserver-utils \
		libxft-dev libxinerama-dev libxrandr-dev xorg curl unzip \
		python3 python3-venv libvirt-daemon-system qutebrowser feh \
		picom gimp xclip zathura npm pip nodejs cargo ripgrep -y
	mkdir -p $(user_home)/.local/share/applications
	cp -i configFiles/defaults.list $(user_home)/.local/share/applications/defaults.list
	echo "Success" > basePackages

addisionalPackages:
	nala install snapd timeshift ninja-build gettext cmake qemu-utils \
		qemu-system qemu-system-x86 virt-manager ovmf -y
	snap install bitwarden
	# adduser $(user) libvirt
	echo "Success" > addisionalPackages

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

resolveEACCES: # not done
	mkdir $(user_home)/.npm-global
	npm config set prefix '$(user_home)/.npm-global'
	printf "%s\n" "export PATH=~/.npm-global/bin:$$PATH" >> $(user_home)/.profile
	#/bin/bash source $(user_home)/.profile
	echo "Success" > resolveEACCES

clean:
	rm -f install basePackages addisionalPackages makeInstall startup fonts warp nvim
	rm -f /usr/bin/nvim
	rm -rf /squashfs-root
