USER_HOME = $$(getent passwd $${SUDO_USER:-$$USER} | cut -d: -f6)
install:
	./install.sh
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	cd neovim && $(MAKE) CMAKE_BUILD_TYPE=Release && sudo make install 
	cp -i .bash_profile $(USER_HOME)/.bash_profile
	cp -i .xinitrc $(USER_HOME)/.xinitrc
	./cloudflareWarp.sh
