# ~/.bashrc: Executado para shells interativos não-login.
# Veja /usr/share/doc/bash/examples/startup-files para exemplos.
# O arquivo principal .bashrc do sistema está em /etc/bash.bashrc

# Se não for interativo, não faça nada
[[ $- != *i* ]] && return

# --- Configurações de PATH ---
# Se você tiver um diretório bin pessoal, adicione-o ao PATH
# PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# --- Configurações de Prompt ---
# Cores para o prompt (se seu terminal suportar)
# PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

# --- Aliases Comuns ---
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# --- Funções ---
# Exemplo de função para criar e entrar em um diretório
# mcd () {
#   mkdir -p "$1"
#   cd "$1"
# }

# --- Configuração do ASDF ---
# Adiciona o asdf ao seu PATH e carrega a autocompleção.
# Substitua "$HOME" pelo seu diretório home se necessário.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"
fi
# --- Fim da Configuração do ASDF ---

# --- Configuração do Direnv ---
# Carrega o direnv se estiver instalado. Essencial para o .envrc funcionar.
if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi
# --- Fim da Configuração do Direnv ---

# --- Configuração do fzf e ripgrep ---
# FZF_DEFAULT_COMMAND: Faz com que fzf use ripgrep para listar arquivos (mais rápido e respeita .gitignore)
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# Carrega os key-bindings e a autocompleção do fzf
if [ -f "$HOME/.fzf.bash" ]; then
  . "$HOME/.fzf.bash"
fi
# --- Fim da Configuração do fzf e ripgrep ---

# --- Outras configurações ---
# Habilitar histórico para múltiplas sessões (apagar o # para ativar)
# HISTCONTROL=ignoreboth
# HISTSIZE=1000
# HISTFILESIZE=2000
# shopt -s histappend
