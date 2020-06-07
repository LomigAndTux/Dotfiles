SHELL=/bin/zsh
PACMAN=sudo /usr/bin/pacman -S --needed
YAY=/usr/bin/yay -S

help:
	@echo 'Makefile for Dotfiles'
	@echo ''
	@echo 'Usage :'
	@echo '    make all 			install everything'
	@echo '    make archlinux		install archlinux'
	@echo '    make bc 			install bc'
	@echo '    make bspwm 			install bspwm'
	@echo '    make bzhfetch 		install bzhfetch'
	@echo '    make git 			install git'
	@echo '    make mpv 			install mpv'
	@echo '    make newsboat 		install newsboat'
	@echo '    make nordvpn 		install nordvpn'
	@echo '    make pacman 			install pacman'
	@echo '    make picom 			install picom'
	@echo '    make polybar			install polybar'
	@echo '    make pulseaudio		install pulseaudio'
	@echo '    make pulsemixer		install pulsemixer'
	@echo '    make python 			install python'
	@echo '    make pywal 			install pywal'
	@echo '    make ranger 			install ranger'
	@echo '    make reflector		install reflector'
	@echo '    make scrot 			install scrot'
	@echo '    make sxhkd 			install sxhkd'
	@echo '    make tmux    		install tmux'
	@echo '    make updown 			install updown'
	@echo '    make yay 			install yay'
	@echo '    make zsh 			install zshrc'

archlinux:
	sudo ln -sf `pwd`/archlinux/coredump.conf /etc/systemd/coredump.conf
	sudo ln -sf `pwd`/archlinux/journald.conf /etc/systemd/journald.conf

bc:
	if [ ! -f /usr/bin/bc ]; then \
		$(PACMAN) bc ;\
	fi
	sudo ln -sf `pwd`/bc/xterm_bc /usr/local/bin/xterm_bc

bspwm: sxhkd polybar
	if [ ! -f /usr/bin/bspwm ];then \
		$(PACMAN) bspwm ;\
	fi
	ln -sf `pwd`/bspwm/bspwmrc ~/.config/bspwm/bspwmrc

bzhfetch:
	sudo ln -sf `pwd`/bzhfetch/bzhfetch /usr/local/bin/bzhfetch
	sudo ln -sf `pwd`/bzhfetch/cs-panes /usr/local/bin/cs-panes

git:
	if [ ! -f /usr/bin/git ]; then \
		$(PACMAN) git ;\
	fi
	ln -sf `pwd`/git/gitconfig ~/.gitconfig

mpv: 
	if [ ! -f /usr/bin/mpv ]; then \
		$(PACMAN) mpv ; \
	fi
	if [ ! -d "~/.config/mpv" ]; \
		then mkdir -p ~/.config/mpv; \
	fi
	ln -sf `pwd`/mpv/mpv.conf ~/.config/mpv/mpv.conf

newsboat:
	if [ ! -f /usr/bin/newsboat ]; then \
		$(PACMAN) newsboat ; \
	fi
	if [ ! -d "~/.config/newsboat" ]; then \
		mkdir -p ~/.config/newsboat; \
	fi
	ln -sf `pwd`/newsboat/config ~/.config/newsboat/config
	ln -sf `pwd`/newsboat/urls ~/.config/newsboat/urls
	sudo ln -sf `pwd`/newsboat/rss /usr/local/bin/rss

nordvpn:
	if [ ! -f /usr/bin/nordvpn ]; then \
		$(YAY) nordvpn-bin ; \
	fi
	sudo ln -sf `pwd`/nordvpn/vpn-randomize /usr/local/bin/vpn-randomize
	sudo ln -sf `pwd`/nordvpn/vpn-status /usr/local/bin/vpn-status

pacman:
	if [ ! -L "/etc/pacman.d/pacman.conf" ];then \
		sudo ln -sf `pwd`/pacman/conf/pacman.conf /etc/pacman.conf ;\
	fi
	if [ ! -f /usr/bin/rankmirrors ]; then \
		$(PACMAN) pacman-contrib ; \
	fi

pacman_hooks: updown reflector
	if [ ! -d "/etc/pacman.d/hooks" ]; then mkdir -p /etc/pacman.d/hooks; fi
	sudo ln -sf `pwd`/pacman/hooks/clean_cache.hook /etc/pacman.d/hooks/clean_cache.hook
	sudo ln -sf `pwd`/pacman/hooks/clean_cache_on_remove.hook /etc/pacman.d/hooks/clean_cache_on_remove.hook
	sudo ln -sf `pwd`/pacman/hooks/lsb-release.hook /etc/pacman.d/hooks/lsb-release.hook
	sudo ln -sf `pwd`/pacman/hooks/mirrorlist.hook /etc/pacman.d/hooks/mirrorlist.hook
	sudo ln -sf `pwd`/pacman/hooks/os-release.hook /etc/pacman.d/hooks/os-release.hook
	sudo ln -sf `pwd`/pacman/hooks/updown.hook /etc/pacman.d/hooks/updown.hook
	sudo ln -sf `pwd`/pacman/bin/hook_lsb-release /usr/local/bin/hook_lsb-release
	sudo ln -sf `pwd`/pacman/bin/hook_os-release /usr/local/bin/hook_os-release
	sudo systemctl daemon-reload
	sudo systemctl start updown.service
	sudo systemctl enable updown.service

picom:
	if [ ! -f /usr/bin/picom ]; then \
		$(PACMAN) picom ;\
	fi
	ln -sf `pwd`/picom/picom.conf ~/.config/picom.conf

polybar: nordvpn
	if [ ! -f /usr/bin/polybar ]; then \
		$(YAY) polybar ;\
	fi
	ln -sf `pwd`/polybar/config ~/.config/polybar/config
	sudo ln -sf `pwd`/polybar/gwen-polybar /usr/local/bin/gwen-polybar
	cp -rf `pwd`/polybar-gmail ~/.config/polybar/gmail
	sudo ln -sf `pwd`/pacman/bin/check_update /usr/local/bin/check_update
	sudo ln -sf `pwd`/pacman/bin/xterm_update /usr/local/bin/xterm_update

pulseaudio:
	sudo ln -sf `pwd`/pulseaudio/default.pa /etc/pulse/default.pa
	sudo ln -sf `pwd`/pulseaudio/main.conf /etc/bluetooth/main.conf

pulsemixer: 
	if [ ! -f /usr/bin/pulsemixer ]; then \
		$(PACMAN) pulsemixer ; \
	fi
	sudo ln -sf `pwd`/pulsemixer/pmix /usr/local/bin/pmix

python:
	if [ ! -d "/usr/local/lib/python/site-packages" ]; then \
		sudo mkdir -p /usr/local/lib/python/site-packages ;\
	fi
	sudo cp -rf `pwd`/python/gwen /usr/local/lib/python/site-packages 

pywal:
	if [ ! -f /usr/bin/wal ]; then \
		$(PACMAN) python-pywal ; \
	fi
	sudo ln -sf `pwd`/pywal/wall-randomize /usr/local/bin/wall-randomize

ranger: 
	if [ ! -f /usr/bin/ranger ]; then \
		$(PACMAN) ranger; \
	fi
	sudo ln -sf `pwd`/ranger/files /usr/local/bin/files

reflector:  
	if [ ! -f /usr/bin/reflector ]; then \
		$(PACMAN) reflector ; \
	fi

scrot: 
	if [ ! -f /usr/bin/scrot ]; then \
		$(PACMAN) scrot; \
	fi
	sudo ln -sf `pwd`/scrot/gwen-scrot-left /usr/local/bin/gwen-scrot-left
	sudo ln -sf `pwd`/scrot/gwen-scrot-main /usr/local/bin/gwen-scrot-main
	sudo ln -sf `pwd`/scrot/gwen-scrot-right /usr/local/bin/gwen-scrot-right

sxhkd: 
	if [ ! -f /usr/bin/sxhkd ]; then \
		$(PACMAN) sxhkd ; \
	fi
	if [ ! -d "~/.config/sxhkd" ]; then \
		mkdir -p ~/.config/sxhkd ; \
	fi
	ln -sf `pwd`/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
	sudo ln -sf `pwd`/sxhkd/gwen-sxhkd /usr/local/bin/gwen-sxhkd

tmux: 
	if [ ! -f /usr/bin/tmux ]; then \
		$(PACMAN) tmux ; \
	fi
	ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf

updown:
	sudo ln -sf `pwd`/pacman/bin/updown /usr/local/bin/updown
	sudo ln -sf `pwd`/pacman/bin/updown-reset /usr/local/bin/updown-reset
	sudo cp -f `pwd`/pacman/systemd/updown.service /etc/systemd/system/updown.service

yay:
	if [ -d "`pwd`/yay" ]; then rm -rf `pwd`/yay; fi
	if [ ! -f /usr/bin/yay ];then \
		git clone https://aur.archlinux.org/yay.git ;\
		cd `pwd`/yay ; makepkg -sri --noconfirm ;\
		rm -rf `pwd`/yay ;\
	fi
zsh: 
	$(PACMAN) grml-zsh-config
	if [ ! -f /usr/bin/pkgfile ]; then \
		$(PACMAN) pkgfile ; \
	fi
	cp -f /etc/skel/.zshrc ~/.zshrc
	cp -f /etc/zsh/zshrc ~/.zshrc.global
	ln -sf `pwd`/zsh/zshenv ~/.zshenv
	ln -sf `pwd`/zsh/zshrc.local ~/.zshrc.local

.PHONY:archlinux bc bspwm bzhfetch git mpv newsboat nordvpn pacman picom pulseaudio pulsemixer polybar python pywal ranger scrot sxhkd tmux zsh
