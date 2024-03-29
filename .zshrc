# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# figure out if we should have a battery prompt or not
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if [[ -d "/proc/acpi/battery/BAT*" ]]; then
        ZSH_THEME="bureau-mod"
    else
        ZSH_THEME="bureau-mod-desk"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    IS_LAPTOP=$(/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book")
    if [[ ! -z "$IS_LAPTOP" ]]; then
        ZSH_THEME="bureau-mod"
    else
        ZSH_THEME="bureau-mod-desk"
    fi
else
    # don't add anything for other OSes
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh-mods

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(battery docker docker-compose python zsh-autosuggestions)

# handy dandy OS logic here
if [[ "$OSTYPE" == "linux-gnu" ]]; then

    # get Distro we're using
    if [[ -x "$(command -v lsb_release)" ]]; then
        DISTRO=$(lsb_release -i | awk '{print $3}')
    else
        DISTRO=$(hostnamectl | grep "Operating System:" | cut -d " " -f 5)
    fi

    if [[ "$DISTRO" == "Fedora" ]]; then
        plugins+=(fedora)
    elif [[ "$DISTRO" == "Ubuntu" ]]; then
        plugins+=(ubuntu command-not-found)
    elif [[ "$DISTRO" == "Debian" ]]; then
        plugins+=(debian)
    else
        # don't add anything if we don't know the distro
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    plugins+=(macos iterm2)
else
    # don't add anything for other OSes
fi

# update automatically, every 13 days
zstyle ':omz:update' frequency   13
zstyle ':omz:update' mode        auto

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Source a global variables file with IPs
[ -f ~/.global_variables ] && . ~/.global_variables

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias ls="ls -Xlh --color=auto"
    alias mv="mv -fv"
    alias cp="cp -fv"
    alias rm="rm -rfv"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls="gls -lh --color=auto"
    alias mv="gmv -fv"
    alias cp="gcp -fv"
    alias rm="grm -rfv"
    # iTerm integration
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    alias sshon="sudo systemsetup -setremotelogin on"
    alias sshoff="sudo systemsetup -setremotelogin off"
else
    # do nothing
fi

# make time look more like bash
TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S'

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tmux="tmux -2"

