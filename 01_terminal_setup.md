# 01. Configuração do Terminal para Produtividade

Um terminal bem configurado é a base para uma experiência de desenvolvimento fluida, especialmente ao trabalhar com editores como Neovim. Este guia detalha como configurar seu terminal para máxima produtividade, com foco no shell Zsh e em ferramentas que o tornam poderoso.

---

## 1. O Shell: Zsh + Oh My Zsh

Enquanto `bash` é o padrão, o **Zsh (Z Shell)** é um upgrade que oferece autocompletar, correção e um sistema de plugins muito superiores. O **[Oh My Zsh](https://ohmy.sh/)** é um framework que gerencia a configuração do Zsh para você, simplificando o uso de temas e plugins.

### Instalação

1.  **Instale o Zsh:**
    ```bash
    # Em distribuições baseadas em Debian (Ubuntu)
    sudo apt update && sudo apt install zsh

    # Em distribuições baseadas em Arch
    sudo pacman -S zsh
    ```

2.  **Instale o Oh My Zsh:**
    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

3.  **Torne o Zsh seu shell padrão:**
    ```bash
    chsh -s $(which zsh)
    ```
    Após executar este comando, saia e entre novamente no seu terminal.

---

## 2. Plugins Essenciais para o Zsh

Plugins adicionam funcionalidades incríveis ao seu shell. Para instalá-los, você geralmente clona o repositório do plugin no diretório de plugins do Oh My Zsh e depois o ativa no seu arquivo `.zshrc`.

O diretório de plugins é: `~/.oh-my-zsh/custom/plugins`.

### a) `zsh-autosuggestions`

Este plugin sugere comandos com base no seu histórico enquanto você digita. Se a sugestão estiver correta, pressione a tecla `→` (seta para a direita) para autocompletar.

**Instalação:**
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### b) `zsh-syntax-highlighting`

Este plugin colore os comandos na linha de comando, mostrando se um comando é válido (verde) ou inválido (vermelho) antes mesmo de você executá-lo.

**Instalação:**
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Ativando os Plugins

Após a instalação, abra seu arquivo `~/.zshrc` e adicione os nomes dos plugins à lista `plugins=(...)`.

**Exemplo:**
```zsh
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z # Plugin 'z' para navegação rápida, já vem com o Oh My Zsh
)
```

---

## 3. `fzf`: Fuzzy Finder para Tudo

`fzf` é uma ferramenta de "fuzzy finding" que permite buscar arquivos, histórico de comandos, processos e muito mais de forma interativa e extremamente rápida.

### Instalação

1.  **Instale o `fzf`:**
    ```bash
    # Em distribuições baseadas em Debian (Ubuntu)
    sudo apt update && sudo apt install fzf

    # Em distribuições baseadas em Arch
    sudo pacman -S fzf
    ```

2.  **Opcional, mas recomendado: Instale o `ripgrep` para buscas mais rápidas:**
    ```bash
    # Em distribuições baseadas em Debian (Ubuntu)
    sudo apt update && sudo apt install ripgrep

    # Em distribuições baseadas em Arch
    sudo pacman -S ripgrep
    ```

### Configuração no `.zshrc`

Adicione as seguintes linhas ao seu `~/.zshrc` para otimizar o `fzf` e integrá-lo com `ripgrep`:

```zsh
# Usa ripgrep para o fzf, respeitando o .gitignore e ignorando arquivos ocultos
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Atalho (Ctrl+T) para usar o fzf para encontrar arquivos
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

---

## 4. `direnv`: Gerenciamento de Variáveis de Ambiente por Projeto

`direnv` é uma ferramenta que carrega e descarrega variáveis de ambiente automaticamente com base no diretório em que você está. Isso é ideal para gerenciar segredos, tokens de API ou configurações específicas de um projeto sem poluir seu `.zshrc`.

### Instalação

```bash
# Em distribuições baseadas em Debian (Ubuntu)
sudo apt update && sudo apt install direnv

# Em distribuições baseadas em Arch
sudo pacman -S direnv
```

### Configuração no `.zshrc`

Adicione a seguinte linha **no final** do seu `~/.zshrc` para que o `direnv` funcione corretamente:

```zsh
eval "$(direnv hook zsh)"
```

### Como Usar

1.  Dentro do diretório do seu projeto, crie um arquivo chamado `.envrc`:
    ```bash
    cd meu-projeto/
    echo 'export DATABASE_URL="meu_valor_secreto"' > .envrc
    ```

2.  Permita que o `direnv` carregue o arquivo:
    ```bash
    direnv allow
    ```

Agora, toda vez que você entrar no diretório `meu-projeto/`, o `direnv` carregará automaticamente as variáveis definidas no `.envrc`. Quando você sair, elas serão removidas do seu ambiente.

---

## 5. Exemplo de um `.zshrc` Básico e Poderoso

```zsh
# --- Configuração do Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # Um tema simples e eficaz

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

# --- Suas Configurações Pessoais Abaixo ---

# Variáveis de Ambiente
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$PATH"

# Configurações do fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias l="ls -la"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"
alias vim="nvim"
alias vi="nvim"
alias vf="nvim \$(fzf)" # Abre um arquivo encontrado com fzf no Neovim
alias hist='history | fzf' # Busca interativa no histórico de comandos

# Histórico de Comandos Compartilhado
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Hook para o direnv (deve ser a última linha)
eval "$(direnv hook zsh)"
```

---

**Próximo:** [Comandos Essenciais do Linux](./02_linux_commands.md)