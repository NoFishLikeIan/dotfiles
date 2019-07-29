# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH="/Users/andreatitton/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(nvm virtualenv ip battery)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

#Truncate dir
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

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

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
        screen
        autojump
        virtualenv
        pip
        zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias sudo="sudo "
alias y="yarn"
alias ys="yarn start"
alias pyvenv="python3 -m venv"
alias activate="source bin/activate"
alias accapp="npx --ignore-existing create-accurapp"
alias py="python3"
alias lein-apprun="lein deps && lein clean && lein figwheel dev"
alias gac="git add . && git commit -m"
alias add-gitignore="npx add-gitignore"
alias py-gitignore="touch .gitignore && curl https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore --output .gitignore &&  echo \"\nbin/\nlib/\" >> .gitignore"
alias rm="rm-safe"
alias myip="curl https://ipinfo.io/ip"
alias cl="clear"
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
alias main-in-env="activate && py main.py"

alias gcc="/usr/local/bin/gcc-9" # CAREFUL, this overwrites the /anaconda3/bin/gcc
alias postgres-start="pg_ctl -D /usr/local/var/postgres start"
alias postgres-stop="pg_ctl -D /usr/local/var/postgres stop"


function jn() {
  if [[ $1 == "-d" ]];
    then
      screen -S notebook -dm jupyter notebook
    else
      jupyter notebook
  fi
}

function ffsend_copy() {
  ffsend upload "$1" | grep -Eo "\http(.*)" | pbcopy
}

function mkgo() {
  mkdir -p "$1" && cd "$1"
}

function rsync_ignore() {
  rsync -azP --delete --filter=":- ${1}/.gitignore" $1 $2
}

function gitemmuort() {
  status = $(curl https://www.githubstatus.com/api/v2/status.json | jq '.status.indicator')
  if [[ status == "none" ]];
    then
      echo "T'appost' uagliò! 🐙"
    else
      echo "Stamo inguaiati"
  fi
}

# imv (interactive mv)
imv() {
  local src dst
  for src; do
    [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
    dst=$src
    vared dst
    [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
  done
}

function newfigwheel() {
  echo "Generating figwheel with reagent in ${1}! 🚀"
  lein new figwheel "$1" -- --reagent
  cd "$1"
  echo "Initiating a git and commiting for you! 🐙"
  touch .gitignore
  curl https://raw.githubusercontent.com/clojure/clojurescript/master/.gitignore --output .gitignore
  git init
  git add .
  git commit -m "First commit for this sexy clojure app! 🎉"
  echo "Opening intelliJ"
  idea .
  echo "Compiling 🛠"

  if [[ $2 == "-d" ]];
    then
      echo "Running detached in screen with name $1! 🛫"
      screen -S "$1" -dm lein figwheel
    else
      lein figwheel
  fi
}

function newflask() {
  if [ -z "$1" ]
    then
      echo "No directory supplied, defaulting to flask_app"
      mkdir flask_app
      cd flask_app
  else
    mkdir $1
    cd $1
  fi

  git clone https://github.com/realpython/flask-skeleton skeleton
  rm -rf skeleton/
  python3 -m venv .
  source bin/activate
  pip install --upgrade pip
  pip install flask flask-cors loguru python-dotenv
  git init
  py-gitignore
  echo 'lib/' >> .gitignore
  echo 'bin/' >> .gitignore

  touch main.py
  curl https://gist.githubusercontent.com/NoFishLikeIan/4b1b918a4fc684d932ff9c772721712d/raw/643ebecb09fbd61877556bad5761f1e5014db1bc/main.py > main.py

  mkdir src
  cd src/
  touch __init__.py
  touch server.py
  curl https://gist.githubusercontent.com/NoFishLikeIan/4b1b918a4fc684d932ff9c772721712d/raw/fe0acfd767de1b7941a3f1721b840afe6ef05743/server.py > server.py
  touch setup.py
  curl https://gist.githubusercontent.com/NoFishLikeIan/4b1b918a4fc684d932ff9c772721712d/raw/930fb9f3fb936b85f4e631eaff088bed0f3dfe40/setup.py > setup.py

  cd ..
  code .

  gac '🎉 first commit! New flask app!'
  python3 main.py
}

# added by Anaconda3 5.2.0 installer
export PATH="/anaconda3/bin:$PATH"

eval $(thefuck --alias)

#!/bin/bash
function rm-safe() {
  if [[ "$1" == "-rf" ]];
    then
      if [[ -z "$2" ]];
        then
          echo "No file to delete given"
    else
      echo "Forced remove $2"
      /bin/rm -rf "$2"
      fi
  else
    FILE="$1"
    TEMP="/tmp"
    if [[ ! -f FILE ]];
      then
        BIN_PATH="$TEMP/$FILE"
        if [[ ! -f "$BIN_PATH" ]];
          then
            mv -f "$FILE" "$TEMP"
            echo "File $FILE moved to /tmp/"
          else
            CURRENT_DATE="$EPOCHSECONDS"
            FILE_WOUT_EXT="${FILE%.*}"
            EXTENSION="${FILE##*.}"
            NEW_FILE_NAME="${FILE_WOUT_EXT}_${CURRENT_DATE}.${EXTENSION}"

            mv "$FILE" "$NEW_FILE_NAME"
            mv -f "$NEW_FILE_NAME" "$TEMP"
            echo "$FILE already found in temp, renamed and moved as $NEW_FILE_NAME"
        fi
      else
        echo "File $FILE not found!"
    fi
  fi
}

function ports() {
  if [ -z "$1" ]
    then
      lsof -Pn -i4
  else
    echo "Checking for port $1"
    lsof -Pn -i4 | grep $1
  fi
}

function loadenv() {
  if [ ! -f .env ]
    then
      export $(cat .env | xargs)
  fi
}

function crun() {
  if [ -z $1 ]
    then
      echo "No file provided"
    else
      echo "---------- Compiling!"
      g++ --verbose $1 -o tmp_out
      echo ""
      echo "---------- Done compiling, outputting!"
      ./tmp_out
  fi
}

# --- GIT
alias gh="open \`git remote -v | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/git@/http:\/\//' -e's/\.git$//' | sed -E 's/(\/\/[^:]*):/\1\//'\`"
alias gpl="git pull --rebase --autostash"
alias git-frwd="git checkout HEAD@{1}"
alias git-tree="git log --graph --oneline --all"
alias config='/usr/bin/git --git-dir=/Users/andreatitton/.cfg/ --work-tree=/Users/andreatitton'
