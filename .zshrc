export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
export TERM=xterm-256color
export EVENT_NOKQUEUE=1
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

rosetta=$(sysctl -n sysctl.proc_translated)


if [ $rosetta -eq 0 ];
then
    echo ">>> CPU_ARCH: m1"
    export PATH=/opt/homebrew/bin:$PATH
else
    echo ">>> CPU_ARCH: rosetta2"
    export PATH=/usr/local/bin:/bin:/usr/bin:$PATH
fi

zmodload zsh/zprof

zplug "zplug/zplug"

# Prezto framework
zplug "sorin-ionescu/prezto", \
  use:"init.zsh", \
  hook-build:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto"

zplug "apriendeau/prezto-slim-prompt", \
  from:github, \
  hook-build:"ln -s $ZPLUG_HOME/repos/apriendeau/prezto-slim-prompt/prompt_slim_setup $ZPLUG_HOME/repos/sorin-ionescu/prezto/modules/prompt/functions"

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:load' pmodule \
  'history-substring-search' \
  'git' \
  'docker' \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'utility' \
  'completion' \
  'prompt' \
  'osx' \
  'python' \
  'fasd' \
  'tmux'

zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:prompt' theme 'slim'


# Custom zsh configuration
zplug "~/.zsh", \
  use:"*.zsh", \
  from:local

zplug load

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

ssh-add -A 2>/dev/null;
