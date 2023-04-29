# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/opt/python@3.7/libexec/bin:$PATH"
# Path to your oh-my-zsh installation.
export ZSH="/Users/jutiboottawong/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#robbyrussell
#gnzh
#powerlevel10k/powerlevel10k

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
plugins=(vi-mode git zsh-autosuggestions)


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

# Configs FZF


set showmatch;
alias v="fzf --preview 'bat --color \"always\" {}'"
alias pview='nvim $(v)'
function cdf() {
    local depth=${1:-1}   # Set default depth to 1 if not specified
    if (( depth >= 0 )); then  # Check if depth is non-negative
        local dir=$(find . -maxdepth $depth -type d -print | fzf)
    else  # If depth is negative, go up the directory tree
	local dir=$(cd .. && cd "$(printf '%0.s../' $(seq 1 $((depth * -1 - 1))))" && pwd)
    fi
    if [ -n "$dir" ]; then  # Check if a directory was selected
        cd "$dir"
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $ZSH/oh-my-zsh.sh
source /usr/local/opt/fzf/shell/key-bindings.zsh 
source /usr/local/opt/fzf/shell/completion.zsh



# Webassembly
alias webAssembly='source /Users/jutiboottawong/Applications/emsdk/emsdk_env.sh'


# Asciinema
function recTerm (){
	today=$(date +%m-%d-%Y);
	asciinema rec "/Users/jutiboottawong/terminalRec/$1-$today";
}


SHELL_SESSION_HISTORY=0

# Python aliases
alias actV='. venv/bin/activate'




# Tmux 
function tattach() {
 tmux attach -t "$1"
}


# Ctags


alias ctags="`brew --prefix`/bin/ctags"
# alias ctags >> ~/.zshrc
ctags=/usr/local/bin/ctags

# ctags alias for specific langauges
alias ctagsPy='ctags -R --languages=python --exclude="virutalenv_run"'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[2 q' ;} # Use beam shape cursor for each new prompt.


# Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line


# Postgres
export PGDATABASE=postgres
export PATH=/usr/local/opt/postgresql@15/bin:$PATH



# Tree
function tree() {
    local depth=${1:-2}
    if (( depth >= 0 )); then
        find . -maxdepth "$depth" -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g" | less -r
    else
        depth=$((depth * -1))
        cd "$(printf '%0.s../' $(seq 1 $depth))"
        mytree
    fi
}
alias ls='colorls'


function change() {
    current_tty=$(tty)
    thumbnails='/Users/jutiboottawong/Documents/background_img_term'
    images=(`ls $thumbnails`)
    num_images=${#images[*]}
    myfilename="${thumbnails}/`echo ${images[$((RANDOM%$num_images + 1))]}`"
    base64filename=$(echo -n "${myfilename}" | base64)
    echo $myfilename > $current_tty
    printf "\033]1337;SetBackgroundImageFile=%s;tile\a" "$base64filename" > "$current_tty"
    unset $RANDOM
}

#Django database migration
alias dj_database='python manage.py makemigrations && python manage.py migrate;'
alias dj_runserver='python manage.py runserver'

alias vim='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



[ -f "/Users/jutiboottawong/.ghcup/env" ] && source "/Users/jutiboottawong/.ghcup/env" # ghcup-env
