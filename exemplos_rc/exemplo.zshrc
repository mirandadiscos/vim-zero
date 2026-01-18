# ~/.zshrc: Executado para shells interativos não-login.

# --- Zsh Options (opções comuns) ---
setopt autocd             # muda de diretório apenas digitando o nome
setopt extendedglob       # habilita padrões de glob avançados
setopt auto_param_keys    # permite que o auto-completar funcione com chaves
setopt no_beep            # desabilita o beep para erros

# --- Configurações de PATH ---
# Se você tiver um diretório bin pessoal, adicione-o ao PATH
# path=("$HOME/bin" "$HOME/.local/bin" $path)

# --- Configurações de Prompt ---
# Exemplo de prompt simples (pode ser personalizado com frameworks como Oh My Zsh)
# PROMPT="%n@%m %B%~%b %# "

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
#   mkdir -p "$1" && cd "$1"
# }

# --- Configuração do ASDF ---
# Adiciona o asdf ao seu PATH e carrega a autocompleção.
# Substitua "$HOME" pelo seu diretório home se necessário.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
  # A autocompleção para zsh é carregada automaticamente com o script principal do asdf.
fi
# --- Fim da Configuração do ASDF ---

# --- Configuração do Direnv ---
# Carrega o direnv se estiver instalado. Essencial para o .envrc funcionar.
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi
# --- Fim da Configuração do Direnv ---

# --- Outras configurações ---
# Habilitar plugins do Oh My Zsh (se estiver usando)
# plugins=(git common-aliases)
# source $ZSH/oh-my-zsh.sh
