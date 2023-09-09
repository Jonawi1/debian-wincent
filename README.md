# debian-wincent

!! Work in progress !!

Update: The installation should work as expected now, but the project is still a work in progress.

## Install
### Dependencies

    git
    make

    git clone https://github.com/Jonawi1/debian-wincent.git
    cd debian-wincent
    sudo make
    sudo reboot

If you for any reason need to do a reinstall run:
    
    sudo make clean install

## Installed patches

### dwm

- alpha
- attachbottom
- autostart
- center
- ceterfirstwindow
- exitmenu
- hide vacant tags
- movestack
- pertag
- restartsig
- tilewide
- vanitygaps

### st

- alpha
- alpha focus

## Windows Virtual Machine with gpu passthrough
https://quantum5.ca/2022/04/20/windows-vm-gpu-passthrough-part-1-basic-windows-vm/
