# See LICENSE file for copyright and license details.

user = $${SUDO_USER:-$$USER}
user_home = $$(getent passwd $(user) | cut -d: -f6)
install: appInstall makeInstall nvChad startup alias fonts
	echo "Success" > install

clean:
	rm -f install appInstall makeInstall nvChad startup fonts
	rm -rf $(user_home)/.config/nvim $(user_home)/.local/share/nvim /root/.config/nvim

appInstall:
	./appInstall.sh
	adduser $(user) libvirt
	./cloudflareWarp.sh
	echo "Success" > appInstall

makeInstall: appInstall
	cd dwm && $(MAKE) clean install
	cd st && $(MAKE) clean install
	cd dmenu && $(MAKE) clean install
	cd slstatus && $(MAKE) clean install
	echo "Success" > makeInstall
	
nvChad: appInstall
	cd neovim && $(MAKE) CMAKE_BUILD_TYPE=Release && sudo make install
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb && sudo dpkg -i ripgrep_13.0.0_amd64.deb
	git clone https://github.com/NvChad/NvChad $(user_home)/.config/nvim --depth 1
	chown -R $(user):$(user) $(user_home)/.config/nvim
	mkdir -p /root/.config
	sudo ln -s $(user_home)/.config/nvim /root/.config
	echo "Success" > nvChad

startup:
	cp -i .bash_profile $(user_home)/.bash_profile
	cp -i .xinitrc $(user_home)/.xinitrc
	cp -i autostart.sh $(user_home)/.dwm/auto_start.sh
	feh --bg-fill ./IMG_20230802_151507.jpg
	echo "Success" > startup

alias:
	printf "%s\n" "alias sudo='sudo '" >> $(user_home)/.bashrc
	printf "%s\n" "alias apt=nala" >> $(user_home)/.bashrc
	printf "%s\n" "alias vim=nvim" >> $(user_home)/.bashrc
	printf "%s\n" "alias ll='ls -lA'" >> $(user_home)/.bashrc
	printf "%s\n" "alias la='ls -a'" >> $(user_home)/.bashrc
	echo "Success" > alias

fonts: appInstall
	mkdir -p $(user_home)/.fonts/JetBrainsMono
	wget -P $(user_home)/.fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
	unzip -d $(user_home)/.fonts/JetBrainsMono $(user_home)/.fonts/JetBrainsMono.zip
	echo "Success" > fonts
