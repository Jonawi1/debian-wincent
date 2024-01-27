# See LICENSE file for copyright and license details.
SHELL := /bin/bash
user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)

install_w: basePackages_w suckless_w nvim-wincent_w kmonad_w
	chown -R $(user):$(user) $(user_home)/
	echo "Success" > install_w
	echo "Now reboot to complete the installation"

basePackages_w:
	apt-get install nala -y
	nala install curl unzip firefox-esr feh picom xclip wireplumber light unclutter-xfixes dunst zathura network-manager gimp -y
	echo "Success" > basePackages_w

suckless_w: startup_w fonts_w
	nala install build-essential libx11-dev libxft-dev libxinerama-dev xorg -y
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	cd wmname && $(MAKE) clean install
	echo "Success" > suckless_w
	
startup_w:
	cp -i configFiles/.bash_profile $(user_home)/.bash_profile
	cp -i configFiles/.xinitrc $(user_home)/.xinitrc
	mkdir -p $(user_home)/.dwm/
	cp -i configFiles/autostart.sh $(user_home)/.dwm/autostart.sh
	cp -i -r slstatus-scripts/ /
	cp -i dotfiles/.bashrc $(user_home)/.bashrc
	cp -i dotfiles/.fancy-prompt.sh $(user_home)/.fancy-prompt.sh
	echo "Success" > startup_w

fonts_w:
	mkdir -p $(user_home)/.fonts/FiraCode
	unzip FiraCode.zip -d $(user_home)/.fonts/FiraCode
	echo "Success" > fonts_w

nvim_w:
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	./nvim.appimage --appimage-extract
	mv squashfs-root /
	ln -s /squashfs-root/AppRun /usr/bin/nvim
	echo "Success" > nvim_w

nvim-wincent_w: nvim_w
	mkdir -p $(user_home)/.config
	git clone https://github.com/jonwin1/nvim-wincent $(user_home)/.config/nvim
	echo "Success" > nvim-wincent_w

resolveEACCES_w: # Not done
	nala install -y ca-certificates curl gnupg
	mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	sudo nala update
	sudo nala install nodejs -y
	echo "Success" > resolveEACCES_w

qemu-kvm_w:
	nala install qemu-system libvirt-daemon-system virt-manager ovmf -y
	echo "Success" > qemu-kvm_w

swipl_w:
	nala install snapd -y
	snap install swi-prolog
	snap alias swi-prolog.swipl swipl
	snap alias swi-prolog.swipl-win swipl-win
	echo "Success" > swipl_w

valgrind_w:
	nala install valgrind -y

stack_w:
	curl -sSL https://get.haskellstack.org/ | sh
	echo "Success" > stack_w

kmonad_w: stack_w
	git clone https://github.com/kmonad/kmonad.git
	cd kmonad && stack install
	mv /root/.local/bin/kmonad /usr/local/bin/
	cp -i configFiles/miryoku_kmonad.kbd $(user_home)/
	echo "$(user_home)/.local/bin/kmonad $(user_home)/miryoku_kmonad.kbd &" >> $(user_home)/.dwm/autostart.sh
	groupadd -f uinput
	usermod -aG input $(user)
	usermod -aG uinput $(user)
	cp -i configFiles/20-uinput.rules /etc/udev/rules.d/ 
	modprobe uinput
	echo "Success" > kmonad_w

clean:
	rm -f *_w
	rm -f /usr/bin/nvim
	rm -rf $(user_home)/.config/nvim
	rm -rf /squashfs-root
	rm -rf /usr/local/bin/stack
	rm -rf kmonad
