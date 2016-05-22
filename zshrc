#Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
#End of lines configured by zsh-newuser-install

#The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc

autoload -U compinit
compinit
#End of lines added by compinstall

#This alters the appearance of autocompletion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

#This sets the option to ignore duplicate history lines
setopt HIST_IGNORE_DUPS

#Persistant rehash for auto-completion
setopt nohashdirs
setopt nohashcmds

# This sets the case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

#This disables autocomplete of unavailable commands
zstyle ':completion:*:functions' ignored-patterns '_*'

#This shows a list of completion options
zstyle ':completion:*' menu select

#This selects the prompt style and sets an exit status indicator
#autoload -U promptinit
#promptinit
#prompt redhat
if [ $SSH_CONNECTION ]; then SSH="%n@%m "; else SSH=""; fi
PROMPT=%1(j.[%j].)'['$SSH%~']'%(!.#.$)' '
RPROMPT=%(?..(%?%))

#This enables the help command
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help &>/dev/null
alias help=run-help

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

#This sets the dynamic window title
case $TERM in
	xterm*|*rxvt*)
	precmd () {print -Pn "\e]0;%n@%m: %~\a"}
	;;
esac

#This prevents SIGSTOP at Ctrl-S
stty -ixon

#This enables the use of colors
#autoload -U colors && colors

#This sets autocd
#setopt autocd

#This sets cd to never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#This removes the trailing slash of directories used as arguments
zstyle ':completion:*' squeeze-slashes true

#This activates auto-correction
setopt correct

#This loads a syntax highlighting plugin
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#This hides gtk3 app messages about not being able to register with accessibility bus
export NO_AT_BRIDGE=1

#This sets autocomplete for aliases
setopt completealiases

#This sets default editor to nano
export EDITOR=nvim

#Aliases
alias -g L="|less -FX"
#alias syu="sudo aura -Syu && sudo aura -Aua"
alias syu="pacaur -Syu && echo "U" > $PANEL_FIFO"
alias rdpkg="pacman -Qtd"
alias clnpkg="~/dotfiles/clnpkg.sh"
alias x="chmod +x"
alias sx="sudo chmod +x"
alias ls="ls -X --color=auto"
alias ll="ls -lh --color=auto"
alias e="nvim"
alias se="sudoedit"
alias ..="cd .."
alias ..2="cd ../.."
alias rm="noglob rm"

alias school="cd ~/Dropbox/School/KAU/"

mkcd ()
{
	mkdir -p "$1";
	cd "$1"
}

ne ()
{
	(urxvt -e vim "$@" &)
}

nse ()
{
	(urxvt -e sudoedit "$@" &)
}

new ()
{
	(urxvt -e "$@" &)
}

#create a zkbd compatible hash;
#to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

#setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
