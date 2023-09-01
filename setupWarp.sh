#!/bin/bash
warp-cli register
warp-cli connect
warp-cli set-mode warp+doh
warp-cli set-families-mode malware
if !(curl https://www.cloudflare.com/cdn-cgi/trace/ | grep "warp=on"); then
	echo "Error: Unable to configure warp" >> /dev/stderr
fi
