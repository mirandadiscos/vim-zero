# Curiosidades e Dicas do Zsh para Devs Backend

O `.zshrc` é o arquivo de configuração do Zsh, localizado em `~/.zshrc`. Ele é executado toda vez que você abre um novo terminal. Frameworks como o [Oh My Zsh](https://ohmy.sh/) facilitam muito a vida, mas aqui estão algumas "curiosidades" e configurações que você pode adicionar manualmente ou que são boas de conhecer.

---

### 1. Aliases (Apelidos) Inteligentes

Aliases são a forma mais simples de economizar tempo. Para um dev backend, alguns exemplos úteis são:

```zsh
# Navegação
alias ..="cd .."
alias ...="cd ../.."

# Git (se você usa Oh My Zsh, muitos já vêm prontos: gst, gp, ga, gc)
alias glog="git log --oneline --graph --decorate"
alias gpush="git push"
alias gpull="git pull"

# Docker
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dps="docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# Listar arquivos com 'ls' melhorado (precisa do 'exa' instalado)
# alias ls='exa -l --icons'
```

**Como adicionar?** Copie as linhas `alias ...` para o final do seu `~/.zshrc`.

---

### 2. Histórico de Comandos Compartilhado e Otimizado

Por padrão, cada terminal tem seu próprio histórico. Isso é péssimo! Você pode fazer com que todos os seus terminais abertos compartilhem o mesmo histórico em tempo real.

```zsh
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

**Curiosidade:** Depois de configurar isso, você pode executar um comando em um terminal e, em outro terminal, apertar a seta para cima e o comando já estará lá!

---

### 3. Navegação Rápida de Diretórios

O Zsh tem truques para agilizar a navegação:

-   **Auto CD:** Se uma linha começa com um nome de diretório, o Zsh entra nele automaticamente, sem precisar do `cd`.
    ```zsh
    # Adicione ao ~/.zshrc
    setopt AUTO_CD
    ```
    Depois disso, em vez de `cd ../project`, você pode apenas digitar `../project` e dar Enter.

-   **Tab Completion Avançado:** O Zsh tem o melhor sistema de autocompletar. Use e abuse da tecla `Tab`.
    -   `git checkout <TAB>`: Ele mostra e autocompleta os nomes das suas branches.
    -   `kill <TAB>`: Mostra os processos que você pode matar.
    -   `dcu <TAB>`: Se o `docker-compose.yml` estiver no diretório, ele pode sugerir os serviços.

---

### 4. `z` - A Navegação Mágica

Isso geralmente requer um plugin (`zsh-z`), mas é uma das ferramentas mais incríveis. O `z` "aprende" os diretórios que você mais visita.

Depois de um tempo de uso, em vez de digitar `cd ~/projects/very/deep/and/annoying/path/to/my-project`, você pode simplesmente digitar:

```sh
z my-project
```

E ele te levará para o diretório correspondente, não importa onde você esteja.

**Como instalar (com Oh My Zsh):** Edite a linha `plugins=(...)` no seu `.zshrc` e adicione `z` à lista. Ex: `plugins=(git z)`.

---

### 5. Prompt do Git (Visualização da Branch)

Se você trabalha com Git, é essencial saber em qual branch você está. A maioria dos temas do Oh My Zsh já faz isso.

Exemplo de prompt: `(main *) ~/projects/my-api`

-   `(main)`: Você está na branch `main`.
-   `*`: Existem arquivos modificados que não foram "commitados".

Isso te dá uma consciência situacional imediata do seu repositório. Se o seu não mostra, procure por "zsh git prompt theme" ou simplesmente troque o tema no seu `.zshrc` (variável `ZSH_THEME`).

```
