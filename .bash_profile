export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/usr/local/opt/mongodb-community@4.0/bin:$PATH"

# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
  
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Run NVM when entering a directory with .nvmrc file
_enter_dir() {
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ "$git_root" == "$PREV_PWD" ]]; then
    return
  elif [[ -n "$git_root" && -f "$git_root/.nvmrc" ]]; then
    nvm use
    NVM_DIRTY=1
  elif [[ "$NVM_DIRTY" == 1 ]]; then
    nvm use default
    NVM_DIRTY=0
  fi
  PREV_PWD="$git_root"
}

export PROMPT_COMMAND=_enter_dir

function kill_port () {
  find_pid="sudo lsof -t -i:$1"
  pid=$(eval "$find_pid")
  if [ ! -z "$pid" ];
  then
    echo "Killing pid $pid"
    sudo kill "$pid"
  else 
    echo "No process on $1"
  fi
}

