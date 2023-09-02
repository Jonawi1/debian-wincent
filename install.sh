#!/bin/bash
sudo apt-get install nala

sudo nala install \
	git \
	make \
	build-essential \
	libx11-dev \
	x11-utils \
  x11-xserver-utils \
	libxft-dev \
	libxinerama-dev \
	libxrandr-dev \
	xorg \
	curl \
	snapd \
	timeshift \
	ninja-build \
	gettext \
	cmake \
	unzip \
	python3-venv \
  libvirt-daemon-system \
  qemu-utils \
  qemu-system \
  qemu-system-x86 \
  virt-manager \
  ovmf \
  qutebrowser

sudo snap install bitwarden
