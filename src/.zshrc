##
#   Manipulate .zshrc file
#
export DOTFILE_ZSHRC="~/.dotfiles/src/.zshrc"
alias change="vim $DOTFILE_ZSHRC" # Open .zshrc to be edited in VS Code
alias resource="source $DOTFILE_ZSHRC" # Re-run source command on .zshrc to update current terminal session with new settings

##
# Spaceship ZSH prompt
#
autoload -U promptinit; promptinit
prompt spaceship

# Enable syntax highlighting in new shell sessions
source /usr/local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Allow the use of the z plugin to easily navigate directories
. /Users/htaidirt/.dotfiles/resources/z.sh

##
#   ColorLS
#
alias l='colorls --group-directories-first --almost-all'
alias ll='colorls --group-directories-first --almost-all --long' # detailed list view

##
#   GIT setups
#
alias diff="git diff"
alias status="git status"
alias add="git add -A"
alias commit="git commit"
alias push="git push"

##
#   Kubernetes and environments
#
alias k="kubectl"

##
#   Helpful aliases
##
alias del_ds_store="find . -name '.DS_Store' -type f -delete"
alias ":q"="exit" # Yeah VIM habits, you know!


##
#   Helpful functions
##

# Check applications that are using a specific port
function port() {
    lsof -i :$1
}

# Search for a pattern in any file within current directory
function search() {
    grep -rnw `pwd` -e $1
}

# Get my external current IP address
# Source: http://apple.stackexchange.com/questions/20547/how-do-i-find-my-ip-address-from-the-command-line)
#
function ip() {
    curl -s http://checkip.dyndns.org/ | sed 's/[a-zA-Z<>/ :]//g'
}

# Create and change directory
#
function take() {
    mkdir -pv "$1"
    cd "$1"
}

# Add SSH key
#
function add_ssh() {
    /usr/bin/ssh-add -K ~/.ssh/id_rsa
}

# Get SHA256 of a text
# Source: http://albertech.blogspot.fr/2015/02/generate-sha-256-hash-from-command-line.html
#
function sha256() {
    echo -n $1 | shasum -a 256
}

# Launch the VS Code Insiders.
# Nota: Open with current folder if no arguments.
#
function code() {
  if [ -z "$*" ]
  then
    code-insiders .
  else
    code-insiders "$*"
  fi
}

# Play with Python virtual environment
#
function venv() {
  case "$1" in
    "init") python3 -m venv venv
      source venv/bin/activate
      if [[ ! -f "requirements.txt" ]]; then
          touch requirements.txt
      fi
      ;;
    "use") source venv/bin/activate
      ;;
    "add") pip3 install $2
      pip3 freeze > requirements.txt
      ;;
    "freeze") pip3 freeze > requirements.txt
      ;;
    *) echo "Invalid option"
      ;;
  esac
}

# Drastic command to purge docker images and volumes
#
function docker_purge() {
    docker rmi -f $(docker images -q)
    docker system prune --force
}

##
#   Set exports for apps
##

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"  # Export NVM settings

export PATH="/Users/htaidirt/.miniconda3/bin:$PATH"  # Add miniconda3 to path

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/htaidirt/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/htaidirt/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/htaidirt/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/htaidirt/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/htaidirt/Workspace/AXA/datastore-injectors/node_modules/tabtab/.completions/slss.zsh
