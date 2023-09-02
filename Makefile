user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)
install.log: appInstall.log makeInstall.log NvChad.log setupStartx.log fixPremissions.log
	echo "Success" > install.log

appInstall.log:
	./install.sh
	./cloudflareWarp.sh
	echo "Success" > appInstall.log

makeInstall.log: appInstall.log
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	echo "Success" > makeInstall.log

NvChad.log: appInstall.log
	cd neovim && $(MAKE) CMAKE_BUILD_TYPE=Release && sudo make install
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && sudo dpkg -i ripgrep_13.0.0_amd64.deb
	git clone https://github.com/NvChad/NvChad $(user_home)/.config/nvim --depth 1
	echo "Success" > NvChad.log

setupStartx.log:
	cp -i .bash_profile $(user_home)/.bash_profile
	cp -i .xinitrc $(user_home)/.xinitrc
	echo "Success" > setupStartx.log

fixPremissions.log:
	sudo chown -R $(user):$(user) $(user_home)
	sudo adduser $(user) libvirt
	echo "Success" > fixPremissions.log
