# Github ssh

### Start ssh-agent

    eval "$(ssh-agent -s)"
    
### Create a key on a new Yubikey

    ssh-keygen -t ed25519-sk -O resident -C "your_email@example.com"

### Temporarily add key to new PC

    ssh-add -K

### Permanently add key to new PC

    ssh-keygen -K
    mv id_ed25519_sk_rk ~/.ssh/id_ed25519_sk

# Linux login/sudo

## Setup

### Install libpam-u2f

    sudo apt install libpam-u2f
    
### Create config directory

    mkdir ~/.config/Yubico
    
### Associate yubikey

    pamu2fcfg > ~/.config/Yubico/u2f_keys
    
### Associate additional keys

    pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
    
## Add key for sudo

    sudo vim /etc/pam.d/sudo

Underneath the line:

    @include common-auth

Add:

	auth	required	pam_u2f.so cue

 And comment out the default auth method to only use the key:

 	#@include common-auth

## Add key for TTY login

	sudo vim /etc/pam.d/login

Underneath the line:

	@include common-auth

Add:

	auth	required	pam_u2f.so cue
