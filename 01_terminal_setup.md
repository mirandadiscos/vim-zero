# 01. Configuração do Terminal para Produtividade

Este guia detalha como configurar seu terminal para máxima produtividade, com foco em ambientes Linux (e WSL no Windows) e no shell Zsh com Oh My Zsh. Um terminal bem configurado é a base para uma experiência de desenvolvimento fluida, especialmente ao trabalhar com editores como Vim ou Neovim.

## Por que um Terminal Moderno e Configurado é Crucial?

1.  **Suporte a Cores (True Color):** Temas modernos usam uma vasta gama de cores (24-bit). Terminais antigos não conseguem exibi-las.
2.  **Renderização de Fontes (Nerd Fonts):** Plugins e ferramentas de terminal usam ícones especiais. Apenas terminais modernos conseguem renderizar essas fontes customizadas.
3.  **Desempenho:** Terminais modernos usam aceleração de GPU para renderizar texto, o que os torna extremamente rápidos e fluidos.
4.  **Integração e Automação:** Um shell configurado permite automatizar tarefas, criar atalhos e integrar ferramentas de forma transparente.

---

## 1. A Escolha Principal para Windows: Windows Terminal

Para usuários de Windows que trabalham com WSL, o **[Windows Terminal](https://aka.ms/terminal)** é a aplicação oficial e moderna da Microsoft, projetada para ser o centro de comando para desenvolvedores.

### Vantagens do Windows Terminal
*   **Desempenho Superior:** Renderização de texto acelerada por GPU.
*   **Integração com WSL:** Detecta automaticamente suas distribuições Linux e cria perfis para elas.
*   **Abas e Painéis (Splits):** Permite organizar múltiplos terminais em uma única janela.
*   **Suporte Completo a Cores e Fontes:** Renderiza temas e Nerd Fonts perfeitamente.
*   **Alta Customização:** Configurado via um arquivo JSON (`settings.json`).

**Onde obter:** [Microsoft Store](https://aka.ms/terminal) (recomendado para atualizações automáticas).

### Outras Alternativas de Terminais (Windows)

*   **[Tabby](https://tabby.sh/):** Altamente configurável, multiplataforma (Electron), com cliente SSH e serial embutido. Pode ser um pouco mais lento que o Windows Terminal.
*   **[Hyper](https://hyper.is/):** Famoso por sua customização "infinita" via HTML/CSS/JS, mas geralmente considerado a opção mais lenta.

---

## 2. Shell Principal: Zsh + Oh My Zsh

Enquanto o `bash` é o padrão, o `zsh` é um upgrade que oferece autocompletar, correção e um sistema de plugins muito superiores. O **[Oh My Zsh](https://ohmy.sh/)** é um framework que gerencia a configuração do `zsh` para você.

*   **Por que usar Oh My Zsh?**
    *   **Gerenciamento de Temas:** Mude a aparência do seu prompt com uma única linha (ex: `ZSH_THEME="agnoster"`).
    *   **Gerenciamento de Plugins:** Instale e ative plugins facilmente.
    *   **Atualizações Automáticas:** Mantém-se atualizado com novas funcionalidades e correções.

*   **Instalação (requer `zsh` e `git`):** 
    ```bash
    # Instale o Zsh primeiro (ex: sudo apt install zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

---

## 3. Configurações Essenciais para seu `.zshrc`

### a) Passo Essencial: Instalar e Configurar uma Nerd Font

Para que seu terminal (e seu Vim/Neovim) exiba ícones e tenha uma aparência moderna, você **precisa** de uma "Nerd Font".

1.  **Escolha e Baixe:** Vá para **[Nerd Fonts](https://www.nerdfonts.com/font-downloads)** e baixe uma fonte. Boas opções são `FiraCode NF` ou `CaskaydiaCove NF`.
2.  **Instale no Windows/Linux:**
    *   **Windows:** Extraia o `.zip` e instale os arquivos de fonte (`.ttf` ou `.otf`) clicando com o botão direito e selecionando "Instalar".
    *   **Linux:** Copie os arquivos `.ttf` ou `.otf` para `~/.local/share/fonts/` e execute `fc-cache -fv`.

#### Configurando o JSON do Windows Terminal
Abra as configurações do Windows Terminal (`Ctrl+,`) e clique em "Abrir arquivo JSON". Encontre o perfil da sua distribuição WSL (na lista `list`) e adicione/modifique a propriedade `font`:

**Exemplo de configuração no `settings.json`:**
```json
{
  // ... outras configurações ...
  "profiles": {
    "list": [
      {
        // Perfil do Ubuntu
        "guid": "{2c4de342-38b7-51cf-b940-2309a097f518}",
        "name": "Ubuntu",
        "commandline": "wsl.exe -d Ubuntu",
        "hidden": false,
        // --- Adicione ou modifique esta seção ---
        "font": {
          "face": "CaskaydiaCove NF",
          "size": 11
        },
        "colorScheme": "Dracula" // Exemplo de tema
        // ------------------------------------
      },
      // ... outros perfis ...
    ]
  },
  // ... resto das configurações ...
}
```
Salve o arquivo JSON e o terminal aplicará as alterações instantaneamente.

### b) Variáveis de Ambiente

Estas variáveis instruem o shell e outros programas sobre como se comportar. Adicione-as ao seu `~/.zshrc`.

```bash
# Define o editor de texto padrão que ferramentas como 'git' usarão.
export EDITOR='nvim'

# Adiciona um diretório de scripts personalizados ao seu PATH de executáveis.
export PATH="$HOME/.local/bin:$PATH"

# Otimização do fzf (conforme visto no guia do fzf).
# Usa ripgrep (rg) para buscas mais rápidas que respeitam .gitignore.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
```

### c) Aliases: Seus Atalhos Pessoais

Aliases são apelidos para comandos longos. Eles são a forma mais rápida de ganhar produtividade. Adicione-os ao seu `~/.zshrc`.

```bash
# Navegação e Listagem
alias ..="cd .."
alias ...="cd ../.." # Novo alias
alias l="ls -l"
alias la="ls -la"
# Se você usa 'exa', pode adicionar:
# alias ls='exa -l --icons'

# Git (essencial)
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"
alias glog="git log --oneline --graph --decorate" # Duplicado, manter um
alias gpush="git push"
alias gpull="git pull"

# Docker (exemplos)
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# Vim/Neovim
alias vim="nvim"
alias vi="nvim"

# Produtividade com fzf
alias hist='history | fzf' # Busca interativa no histórico de comandos
alias vf="nvim \"
$(fzf)\""      # Encontra um arquivo com fzf e o abre no nvim
```

### d) Histórico de Comandos Compartilhado e Otimizado

Faça com que todos os seus terminais abertos compartilhem o mesmo histórico em tempo real, adicionando ao seu `~/.zshrc`.

```bash
# ~/.zshrc

# Tamanho do histórico
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Ignora comandos duplicados no histórico
setopt HIST_IGNORE_DUPS

# Adiciona o comando ao histórico assim que é executado (não ao fechar o terminal)
setopt INC_APPEND_HISTORY

# Compartilha o histórico entre todos os terminais abertos
setopt SHARE_HISTORY
```

### e) Navegação Rápida de Diretórios

O Zsh tem truques para agilizar a navegação. Adicione ao seu `~/.zshrc`.

```zsh
# Adicione ao ~/.zshrc
setopt AUTO_CD
```
Depois disso, em vez de `cd ../project`, você pode apenas digitar `../project` e dar Enter.

O Zsh também tem um autocompletar avançado que você pode aproveitar com a tecla `Tab`.

### f) `z` - A Navegação Mágica

Isso geralmente requer um plugin (`zsh-z`), mas é uma das ferramentas mais incríveis. O `z` "aprende" os diretórios que você mais visita.

Depois de um tempo de uso, em vez de digitar `cd ~/projects/very/deep/and/annoying/path/to/my-project`, você pode simplesmente digitar:

```sh
z my-project
```
E ele te levará para o diretório correspondente, não importa onde você esteja.

**Como instalar (com Oh My Zsh):** Edite a linha `plugins=(...)` no seu `.zshrc` e adicione `z` à lista. Ex: `plugins=(git z)`.

### g) Prompt do Git (Visualização da Branch)

Se você trabalha com Git, é essencial saber em qual branch você está. A maioria dos temas do Oh My Zsh já faz isso. Se o seu não mostra, procure por "zsh git prompt theme" ou simplesmente troque o tema no seu `.zshrc` (variável `ZSH_THEME`).

---

## 4. Exemplo de um `.zshrc` Básico e Poderoso

```bash
# --- Configuração do Oh My Zsh ---
# Path para o Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema do Oh My Zsh. 'agnoster' é popular (requer Nerd Font). 'robbyrussell' é o padrão.
ZSH_THEME="robbyrussell"

# Lista de plugins a serem carregados.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z # Adicionado para navegação mágica
)

# Carrega o Oh My Zsh. Deve vir DEPOIS de definir plugins e tema.
source $ZSH/oh-my-zsh.sh


# --- Suas Configurações Pessoais Abaixo ---

# Variáveis de Ambiente
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Aliases
alias ..="cd .."
alias ...="cd ../.."
alias l="ls -la"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"
alias glog="git log --oneline --graph --decorate"
alias gpush="git push"
alias gpull="git pull"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"
alias vim="nvim"
alias vi="nvim"
alias vf="nvim \"
$(fzf)\""
alias hist='history | fzf'


# Histórico de Comandos Compartilhado
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Navegação Rápida
setopt AUTO_CD

# Hook para o direnv (deve ser a última linha)
eval "$(direnv hook zsh)"

---

**Próximo:** [Guia de Comandos Linux para Desenvolvedores](./02_linux_commands.md)