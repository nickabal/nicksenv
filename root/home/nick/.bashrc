# .bashrc

# Share histories between terminals
# Avoid duplicates
#export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
#shopt -s histappend
# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


##########
#
# Generic
#
##########


# Recusive wgets
alias wgetR2='wget -m -e robots=off --no-parent'
alias wgetR='wget -r -nH -e robots=off --no-parent --reject="index.*"'
alias wgetRmp3='wget -m -e robots=off --no-parent --accept="*.mp3"'

# User specific aliases and functions
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias la='ls -lA'
alias rt='sudo su -'


##########
#
# Void - XBPS
#
##########


search_function() {
  xbps-query -Rs $1 | grep -v 32bit
}
search_function3() {
  xbps-query -Rs $1
}

search_functiondg() {
  xbps-query -Rs $1 | grep -v 32bit | grep $2
  xbps-query -Rs $2 | grep -v 32bit | grep $1
}
query_xbps() {
echo  xbps-query $1 $2
  xbps-query $1 $2
  return $?
}

provides_function() {
case $1 in
"reg"*)
  options='-s'
  search=$2
  match=''
  remote=no
  ;;
"remote"*)
  options='-Rs'
  search=$2
  match=''
  remote=yes
  ;;
"all"*)
  options='-Rl'
  search=''
  match=$2
  remote=yes
  ;;
*)
  options="caughtatbottom"
  exit "caught here"
  ;;
esac
for package in $(xbps-query $options $search | awk '{print $2}' | rev | cut -f2- -d "-" | rev); do 
  result=`query_xbps $options $package`
    if [[ -n "$result" ]]; then
      if [[ -z "$search" ]]; then
        xbps-query -f $package | grep $match 2>&1 > /dev/null
        if [[ $? == 0 ]]; then
	  echo 
          echo -e "\033[1m"$package":\033[0m"
	  xbps-query -f $package | grep $match
        fi
      else
        echo
        echo -e "\033[1m"$package":\033[0m"
        if [[ "$remote" == "yes" ]]; then
          xbps-query -Rf $package
        else
	  xbps-query -f $package
        fi
      fi
    fi
done
}

# Which files local package(s) provide
alias providesl='provides_function reg'
# Which files remote package(s) provide
alias providesr='provides_function remote'
# Search for file in all packages
alias providesf='provides_function all'
# Search
alias search='search_function'
# Search with double grep
alias searchdg='search_functiondg'
# Search including 32bit
alias search3='search_function3'
# Install 
alias inst='sudo xbps-install -Sy'



##########
#
# Nixos 
#
##########

nixsearch () {
nix-env -qaP '*' --description | grep -i $1
}
alias nix-search='nixsearch'




# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
# For systems without persistent /etc/
elif [ -f ./.etcbashrc ]; then
        . ./.etcbashrc
fi
