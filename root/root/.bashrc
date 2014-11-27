# .bashrc

# User specific aliases and functions
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias rt='sudo su -'

nixsearch () {
nix-env -qaP '*' --description | grep -i $1
}

alias nix-search='nixsearch'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
