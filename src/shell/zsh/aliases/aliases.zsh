# Command upgrades
alias ll="ls -alh"
alias ln="ln -v"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias vi="/usr/bin/vim"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

# Navigation
alias dotfiles="cd $DOTFILES"

# Maintenance
alias pid="ps x | grep -i $1"
alias grep="grep --color=auto"
alias aliases="code $DOTFILES/src/shell/zsh/aliases/aliases.zsh"

# Update
# alias pacmanup="sudo pacman -Syu"
# alias gemup="gem update --system; gem update; gem cleanup"
# alias npmup="npm -g update; npm install -g npm"
# alias yayup="yay -Syu"
# alias update="pacmanup; gemup; npmup; yayup"

# Network
alias network.ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias network.ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias network.speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - --server 24215"
alias network.ping='prettyping --nolegend'
alias ping=network.ping

# Flush Directory Service cache
alias network.flush="sudo nscd -K && sudo nscd && sudo systemd-resolve --flush-caches && echo 'DNS flushed'"

# Utils
alias clean.node="rm -rf node_modules"
alias clean.npm="clean.node && npm cache verify && npm install"
alias clean.yarn="clean.node && yarn"
alias json="python -mjson.tool"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"
