#add nixos green prompt

if (( "$UID" == "0" )); then

export PS1='\[\033]2;\h:\u:\w\007\]\n\[\033[1;31m\][\u@\h:\w]\$\[\033[0m\]'

else

export PS1='\[\033]2;\h:\u:\w\007\]\n\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\]'

fi

