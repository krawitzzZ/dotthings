# If you come from bash you might have to change your $PATH.  # export PATH=$HOME/bin:/usr/local/bin:$PATH

# hello, it is me
export ME="$(whoami)"
export MY_HOME="/home/${ME}"

# Path to your oh-my-zsh installation.
export ZSH="/home/${ME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="geoffgarside"
ZSH_THEME="spaceship"

# SPACESHIP configuration
SPACESHIP_PROMPT_ORDER=(
  battery       # Battery level and status
  # time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # package       # Package version
  node          # Node.js section
  # elixir        # Elixir section
  # swift         # Swift section
  golang        # Go section
  # rust          # Rust section
  haskell       # Haskell Stack section # stack is being weird here...
  # docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # conda         # conda virtualenv section
  pyenv         # Pyenv section
  # kubectl       # Kubectl context section
  line_sep      # Line break
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  exec_time     # Execution time
  exit_code     # Exit code section
)

SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=30
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_CHAR_PREFIX=' '
# SPACESHIP_CHAR_SYMBOL=' '
SPACESHIP_CHAR_SYMBOL=' '
SPACESHIP_CHAR_SUFFIX=' '
SPACESHIP_DIR_PREFIX=' '
SPACESHIP_BATTERY_PREFIX=' '
SPACESHIP_BATTERY_SUFFIX=''

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 3

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins=(
  asdf
  # battery
  # colored-man-pages
  git
  # aws
  cabal
  colorize
  command-not-found
  docker
  docker-compose
  # autoenv
  git-auto-fetch
  golang
  cabal
  # kubectl
  # minikube
  npm
  stack
  rust
  zsh-autosuggestions
)


source $ZSH/oh-my-zsh.sh
source "$MY_HOME"/z/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "$MY_HOME/.ghcup/env" ] && source "$MY_HOME/.ghcup/env" # ghcup-env

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='hx'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


# z navigation
eval "$(zoxide init zsh)"

function killport() {
  kill -9 "$(lsof -t -i:"$1")"
}

function swagit() {
    if [ "$1" != "" ]
    then
        docker run -p 8085:8080 -e SWAGGER_JSON=/foo/${1} -v $(pwd):/foo swaggerapi/swagger-ui
    else
        docker run -p 8085:8080 -e SWAGGER_JSON=/foo/swagger.yaml -v $(pwd):/foo swaggerapi/swagger-ui
    fi
}

function add-ssh() {
  ssh-add ~/.ssh/id_rsa
  ssh-add ~/.ssh/git_rsa
}

weather() {
    if [ "$1" != "" ]
    then
        curl wttr.in/"$1"
    else
        curl wttr.in
    fi
}

cdl() {
    z "$1"
    ls -FGAhp --color=always
}

ss() {
  git stash -ku
}

sr() {
  git stash pop
}

fpath+=~/.zfunc
autoload -Uz compinit && compinit

export XDG_DATA_HOME="$HOME/.local"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_IM_MODULE="xim"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/go/bin:$PATH"
export PATH="$HOME/.local/neovim/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"

# emacs related stuff
export RIPGREP_CONFIG_PATH="${MY_HOME}/.ripgreprc"
export PATH="$HOME/.emacs.d/bin:$PATH"

# node version management
export N_PREFIX="${MY_HOME}/node-n"
export PATH="$N_PREFIX/bin:$PATH"

# shortnahd vars
export zf="$HOME/.zshrc"
export ncf="$HOME/.config/nvim"
export xcf="$HOME/.config/helix"

# Generated for envman for rust. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# autostart ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="$(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> "$HOME"/.ssh/ssh-agent
   fi
   eval "$(cat "$HOME"/.ssh/ssh-agent)"
fi

# some aliases
alias cd="cd"
alias ~="cd ~"
alias ls='ls -FGAhp --color=always'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias python='python3'
alias pip='pip3'
alias ll='ls -FGlAhp --color=always'
alias c='clear'
alias ..='cd ../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias path='echo -e ${PATH//:/\\n}'
alias make1mb='mkfile 1m ./1MB.dat'
alias make5mb='mkfile 5m ./5MB.dat'
alias make10mb='mkfile 10m ./10MB.dat'
alias make24mb='mkfile 24m ./24MB.dat'
alias make25mb='mkfile 25m ./25MB.dat'
alias make50mb='mkfile 50m ./50MB.dat'
alias clip='xclip -sel clip'
alias gf='git fetch --tags --all --prune -f'
alias gp='gf && git pull'
alias gdd="git describe --tags --always | tr -d '[:space:]'"
alias gddc="gdd && gdd | clip"
alias dp='yes | docker system prune --all --force --volumes && yes | docker image prune --all && yes | docker container prune --force && yes | docker volume prune --force'
alias swagedit='docker run -p 8085:8080 swaggerapi/swagger-editor'
alias postgr='docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:latest'
alias yolo='echo "$(curl -s http://whatthecommit.com/index.txt)"'
alias tscp='termscp'

alias aptGetUpdate='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove && sudo apt-get autoclean'
alias aptUpdate='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean'
alias sup='omz update && aptGetUpdate && aptUpdate'
alias cc='cdl'
alias ff='goful'
alias fm='fman'
alias ld='lazydocker'
alias lg='lazygit'
alias x='hx'
alias xz='x ~/.zshrc'
alias xc='x ~/.config'
alias diff='colordiff'
alias cat='ccat'
