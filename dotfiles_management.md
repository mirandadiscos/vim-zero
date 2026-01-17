# Guia: Gerenciando Dotfiles com Git e GitHub

"Dotfiles" são os arquivos de configuração no seu diretório home que começam com um ponto (ex: `~/.vimrc`, `~/.zshrc`, `~/.gitconfig`). Eles contêm a "alma" do seu ambiente de desenvolvimento personalizado.

Gerenciá-los com Git é uma das melhores práticas que você pode adotar.

### Por que Versionar seus Dotfiles?

1.  **Backup:** Se você perder sua máquina, pode recriar seu ambiente perfeitamente configurado em minutos.
2.  **Portabilidade:** Clone seus dotfiles em qualquer nova máquina (ou servidor remoto) e tenha seu ambiente de trabalho instantaneamente.
3.  **Histórico:** Fez uma alteração que quebrou tudo? `git revert` é seu melhor amigo. Você pode experimentar novas configurações com segurança.
4.  **Fonte Única da Verdade:** Seu ambiente de desenvolvimento se torna consistente em todas as máquinas que você usa.

---

## O Método do Repositório "Bare"

Existem muitas maneiras de gerenciar dotfiles, mas a mais elegante e menos intrusiva é usar um **repositório Git "bare" (nu)**.

*   **O que é?** Um repositório "bare" não tem uma "working tree" (a árvore de arquivos que você normalmente vê). Ele armazena apenas os dados do Git (o histórico, commits, etc.), como se fosse o próprio diretório `.git`.
*   **Por que usar?** Isso permite que você versione arquivos diretamente no seu diretório `home` sem criar um repositório Git na raiz (`~/`), o que causaria conflitos com todos os outros repositórios Git em subdiretórios.

---

## Guia Passo a Passo

### 1. Configuração Inicial

1.  **Crie o repositório "bare":**
    Vamos criar um diretório oculto para armazenar os dados do nosso Git.
    ```bash
    git init --bare $HOME/.dotfiles
    ```

2.  **Crie um alias:** Este é o truque principal. Vamos criar um comando `dotgit` que atua como o comando `git`, mas especificamente para o nosso repositório de dotfiles.
    ```bash
    alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```

3.  **Adicione o alias ao seu `.zshrc` ou `.bashrc`:**
    Para que o comando `dotgit` esteja sempre disponível, adicione a linha do alias ao seu arquivo de configuração do shell e recarregue-o (`source ~/.zshrc`).

### 2. Primeiro Commit

1.  **Ignore arquivos não rastreados:** Para evitar que o `dotgit status` mostre todos os arquivos do seu diretório home, configure-o para não mostrar arquivos não rastreados.
    ```bash
    dotgit config --local status.showUntrackedFiles no
    ```

2.  **Adicione seus dotfiles:** Agora, comece a adicionar os arquivos que você quer gerenciar.
    ```bash
    dotgit add ~/.vimrc
    dotgit add ~/.zshrc
    dotgit add ~/.gitconfig
    # Adicione outros arquivos que você customizou...
    ```

3.  **Faça o commit:**
    ```bash
    dotgit commit -m "Initial dotfiles commit"
    ```

### 3. Conectando ao GitHub

1.  **Crie um novo repositório no GitHub:** Vá para o GitHub e crie um novo repositório **privado** chamado `dotfiles`. (É melhor que seja privado, pois pode conter informações sensíveis).

2.  **Adicione o remote:**
    ```bash
    dotgit remote add origin git@github.com:SEU_USUARIO/dotfiles.git
    ```

3.  **Envie seus dotfiles:**
    ```bash
    dotgit push -u origin master
    ```

### 4. Clonando em uma Nova Máquina (A Recompensa)

Agora, em uma máquina nova e limpa:

1.  **Clone o repositório:**
    ```bash
    git clone --bare git@github.com:SEU_USUARIO/dotfiles.git $HOME/.dotfiles
    ```

2.  **Defina o alias `dotgit`:** Adicione o mesmo alias ao `.bashrc` ou `.zshrc` da nova máquina e recarregue o shell.
    ```bash
    alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    source ~/.zshrc
    ```

3.  **"Checkout" dos seus arquivos:**
    ```bash
    dotgit checkout
    ```
    **Atenção:** Este comando pode falhar se houver dotfiles padrão já existentes (ex: um `.bashrc` padrão). O Git fará isso para evitar sobrescrever arquivos.

4.  **Resolvendo conflitos de checkout:** Se o passo anterior falhar, a solução é mover ou deletar os arquivos conflitantes.
    ```bash
    # Faça um backup dos arquivos existentes, caso precise
    mkdir -p ~/.dotfiles-backup
    dotgit checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles-backup/{}

    # Tente o checkout novamente
    dotgit checkout
    ```

Pronto! Seu ambiente de shell e Vim está agora idêntico ao da sua máquina original.

---

## O que Adicionar ao seu Repositório `dotfiles`?

Aqui estão exemplos do que você pode adicionar.

<details>
<summary>Exemplo de <code>.vimrc</code></summary>

```vim
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-explorer', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
" ... outros plugins ...
call plug#end()

" Configurações de UI
set number
set completeopt=menuone,noinsert,noselect

" Mapeamentos
nnoremap <silent> <space>e :CocCommand explorer<CR>
nmap <silent> gd <Plug>(coc-definition)
" ... outras configurações ...
```
</details>

<details>
<summary>Exemplo de <code>.zshrc</code></summary>

```bash
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Variáveis de Ambiente
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Aliases
alias g="git"
alias gs="git status"
alias vim="nvim"
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

eval "$(direnv hook zsh)"
```
</details>

---

**Anterior:** [Guia de Comandos Linux para Desenvolvedores](./linux_commands.md) | **Próximo:** [Guia Extra: Usando Vim + Gemini para Superprodutividade](./vim_gemini.md)
