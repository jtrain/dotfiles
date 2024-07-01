# The following lines were added by compinstall
if [ -e /mnt/procedureus ]; then
    cd /mnt/procedureus
fi

zstyle ':completion:*' completer _complete _ignored

zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
zstyle :compinstall filename '/home/forum/.zshrc'
fpath=(~/.zsh $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='%F{green}%n@%m%f:%F{blue}%B%~%b%f$ '
else
    PS1='\u@\h:\w\$ '
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# also run the .profile since it doesn't seem to run when i sudo into my user.
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

unsetopt complete_aliases


if [ -f /Users ]; then
    # mac specific stuff.
    export PATH=$PATH:/Users/whit/.spicetify

    export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.2.0/bin:$PATH"

    if [ "$(arch)" = "arm64" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi


    function gpg_cache() {
        gpg-connect-agetn /bye &> /dev/null
        eval $(op signin)
        op item get zm2rihblcng4tde4xcbadyc24u --fields password | /opt/homebrew/opt/gpg2/libexec/gpg-preset-passphrase --preset 1168C79BD155B59F8F45BE309CACD7F0FBCCCDA7
    }

    gpg_cache
fi
