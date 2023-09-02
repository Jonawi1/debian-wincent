user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)
install: appInstall makeInstall NvChad
	cp -i .bash_profile $(user_home)/.bash_profile
	cp -i .xinitrc $(user_home)/.xinitrc
	sudo chown -R $(user):$(user) $(user_home)

appInstall:
	./install.sh
	./cloudflareWarp.sh

makeInstall: appInstall
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install

NvChad: appInstall
	cd neovim && $(MAKE) CMAKE_BUILD_TYPE=Release && sudo make install
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && sudo dpkg -i ripgrep_13.0.0_amd64.deb
	git clone https://github.com/NvChad/NvChad $(user_home)/.config/nvim --depth 1
	touch NvChad
