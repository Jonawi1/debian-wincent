# See LICENSE file for copyright and license details.

user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)

install: basePackages makeInstall startup alias fonts
	chown -R $(user):$(user) $(user_home)/
	echo "Success" > install

basePackages:
	apt-get install nala -y
	nala purge nano -y
	nala install build-essential libx11-dev x11-utils x11-xserver-utils \
		libxft-dev libxinerama-dev libxrandr-dev xorg curl unzip \
		python3-venv libvirt-daemon-system qutebrowser feh picom gimp \
		xclip zathura npm neovim -y
	mkdir -p $(user_home)/.local/share/applications
	cp -i configFiles/defaults.list $(user_home)/.local/share/applications/defaults.list
	echo "Success" > basePackages

addisionalPackages:
	nala install snapd timeshift ninja-build gettext cmake qemu-utils \
		qemu-system qemu-system-x86 virt-manager ovmf -y
	snap install bitwarden
	#adduser $(user) libvirt
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

nvChad: 
	cd neovim && $(MAKE) CMAKE_BUILD_TYPE=Release && sudo make install
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && sudo dpkg -i ripgrep_13.0.0_amd64.deb
	git clone https://github.com/NvChad/NvChad $(user_home)/.config/nvim --depth 1
	chown -R $(user):$(user) $(user_home)/.config/nvim
	mkdir -p /root/.config
	sudo ln -s $(user_home)/.config/nvim /root/.config
	echo "Success" > nvChad

clean:
	rm -f install basePackages addisionalPackages makeInstall startup fonts warp

cleanNvChad:
	rm -f nvChad
	rm -rf $(user_home)/.config/nvim $(user_home)/.local/share/nvim /root/.config/nvim
