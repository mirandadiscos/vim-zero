# Guia: Configurando seu Terminal para Produtividade

Um Vim superpoderoso é metade da equação. A outra metade é um ambiente de shell (terminal) que seja igualmente inteligente e rápido. O arquivo de configuração do seu shell (ex: `~/.bashrc` ou `~/.zshrc`) é executado toda vez que você abre um novo terminal, preparando o ambiente para você.

Este guia foca em como otimizar esse ambiente, com preferência para o **Zsh** e o framework **Oh My Zsh**.

---

## 1. A Base: Zsh + Oh My Zsh

Enquanto o `bash` é o padrão, o `zsh` é um upgrade que oferece autocompletar, correção e um sistema de plugins muito superiores. O **[Oh My Zsh](https://ohmyz.sh/)** é um framework que gerencia a configuração do `zsh` para você.

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

## 2. Configurações Essenciais para seu `.zshrc`

### a) Variáveis de Ambiente
Estas variáveis instruem o shell e outros programas sobre como se comportar.

```bash
# Define o editor de texto padrão que ferramentas como 'git' usarão.
export EDITOR='nvim'

# Adiciona um diretório de scripts personalizados ao seu PATH de executáveis.
export PATH="$HOME/.local/bin:$PATH"

# Otimização do fzf (conforme visto no guia do fzf).
# Usa ripgrep (rg) para buscas mais rápidas que respeitam .gitignore.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
```

### b) Aliases: Seus Atalhos Pessoais
Aliases são apelidos para comandos longos. Eles são a forma mais rápida de ganhar produtividade.

```bash
# Navegação e Listagem
alias ..="cd .."
alias l="ls -l"
alias la="ls -la"

# Git (essencial)
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gl="git log --oneline --graph --decorate"

# Vim/Neovim
alias vim="nvim"
alias vi="nvim"

# Produtividade com fzf
alias hist='history | fzf' # Busca interativa no histórico de comandos
alias vf="nvim \$(fzf)"      # Encontra um arquivo com fzf e o abre no nvim
```

---

## 3. Plugins do Shell (para Oh My Zsh)

Você ativa plugins adicionando seus nomes à lista `plugins=(...)` no seu `.zshrc`.

**Plugins Indispensáveis (instale-os dentro de `~/.oh-my-zsh/custom/plugins`):**
1.  **`git`:** Vem com Oh My Zsh. Fornece atalhos e informações do git no prompt.
2.  **`zsh-autosuggestions`:** Sugere comandos em tempo real com base no seu histórico.
    *   `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
3.  **`zsh-syntax-highlighting`:** Colore os comandos, mostrando se são válidos antes de executá-los.
    *   `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

---

## 4. Nível Profissional: Variáveis de Ambiente por Projeto com `direnv`

É uma má prática poluir seu `.zshrc` global com variáveis de ambiente específicas de um projeto (como `DATABASE_URL` ou `API_KEY`). A ferramenta `direnv` resolve isso.

*   **O que é?** `direnv` carrega e descarrega automaticamente variáveis de ambiente quando você entra e sai de um diretório.
*   **Como funciona?** Ao entrar em um diretório, ele procura por um arquivo `.envrc`. Se encontrar, ele o executa. Ao sair, ele reverte as alterações.

### Configuração do `direnv`
1.  **Instale:** `sudo apt install direnv`
2.  **Adicione o "hook" ao seu `.zshrc`:** Adicione esta linha no final do seu `.zshrc`.
    ```bash
    eval "$(direnv hook zsh)"
    ```
3.  **Use:**
    *   Crie um arquivo `.envrc` na raiz do seu projeto: `echo "export API_KEY=12345" > .envrc`
    *   Execute `direnv allow` uma vez para permitir a execução.
    *   Agora, toda vez que você entrar nesse diretório, a variável `$API_KEY` estará disponível.

---

## 5. Exemplo de um `.zshrc` Básico e Poderoso

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
alias l="ls -la"
alias g="git"
alias gs="git status"
# ... outros aliases ...
alias vim="nvim"
alias vi="nvim"
alias vf="nvim \$(fzf)"


# Hook para o direnv (deve ser a última linha)
eval "$(direnv hook zsh)"

---

**Anterior:** [Guia: Terminais para Windows para WSL e Vim](./windows_terminals.md) | **Próximo:** [Guia de Comandos Linux para Desenvolvedores](./linux_commands.md)
```