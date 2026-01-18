# 07. Ferramentas de Produtividade e Dotfiles

Este guia aborda duas práticas essenciais para qualquer desenvolvedor: gerenciar suas configurações (dotfiles) com Git e usar ferramentas que otimizam o fluxo de trabalho no terminal.

---

## 1. Gerenciando Dotfiles com Git

"Dotfiles" são os arquivos de configuração no seu diretório home (ex: `~/.config/nvim/init.lua`, `~/.zshrc`). Versioná-los com Git é uma das melhores práticas que você pode adotar.

**Por que versionar seus dotfiles?**
- **Backup e Restauração:** Se você trocar de máquina, pode recriar seu ambiente perfeitamente configurado em minutos.
- **Portabilidade:** Clone seus dotfiles em qualquer novo servidor ou computador e tenha seu ambiente de trabalho instantaneamente.
- **Histórico de Mudanças:** Fez uma alteração que quebrou tudo? `git revert` é seu melhor amigo.

### O Método do Repositório "Bare"

A maneira mais elegante de gerenciar dotfiles é usar um **repositório Git "bare"**. Isso permite versionar arquivos diretamente no seu diretório `home` sem criar um repositório Git na raiz (`~/`), o que causaria conflitos com todos os outros projetos.

### Guia Passo a Passo

1.  **Criação do Repositório "Bare"**
    ```bash
    # Crie o repositório 'bare' (sem work tree) em uma pasta oculta
    git init --bare $HOME/.dotfiles
    ```

2.  **Criação de um Alias**
    Para interagir com este repositório, criaremos um alias. Adicione ao seu `.zshrc` ou `.bashrc`:
    ```bash
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```
    Após adicionar, recarregue seu shell (`source ~/.zshrc`). Agora você pode usar `config` como se fosse `git`, mas para seus dotfiles.

3.  **Primeiro Commit**
    ```bash
    # Configure o repositório para não mostrar arquivos não rastreados (opcional, mas limpa a saída)
    config config --local status.showUntrackedFiles no

    # Adicione seus arquivos de configuração
    config add ~/.config/nvim/init.lua
    config add ~/.zshrc

    # Faça o commit
    config commit -m "Initial dotfiles commit"
    ```

4.  **Conectando ao GitHub**
    Crie um repositório **privado** no GitHub chamado `dotfiles` e envie seus arquivos:
    ```bash
    config remote add origin git@github.com:SEU_USUARIO/dotfiles.git
    config push -u origin main
    ```

5.  **Clonando em uma Nova Máquina**
    ```bash
    # Clone o repositório bare
    git clone --bare git@github.com:SEU_USUARIO/dotfiles.git $HOME/.dotfiles

    # Defina o mesmo alias 'config' no .zshrc da nova máquina e recarregue o shell

    # Faça o "checkout" dos seus arquivos
    config checkout
    ```
    Se houver conflitos com arquivos existentes, o Git avisará. Faça backup dos arquivos antigos e tente o checkout novamente.

### Lidando com Segredos

**Nunca** comite segredos (tokens, chaves de API) em seus dotfiles. Use um arquivo `.local` ou `.private` que seja ignorado pelo Git.

1.  Crie um arquivo `~/.config_local` para seus segredos:
    ```bash
    # ~/.config_local
    export GITHUB_TOKEN="seu_token_super_secreto"
    ```

2.  Adicione `~/.config_local` ao seu `~/.gitignore` global ou ao `.gitignore` do seu repositório de dotfiles. Com o método "bare", você pode criar um arquivo de exclusão em `$HOME/.dotfiles/info/exclude`.
    ```bash
    # Adicione a linha ao arquivo de exclusão
    echo ".config_local" >> ~/.dotfiles/info/exclude
    ```

3.  Carregue este arquivo no seu `.zshrc`:
    ```bash
    # ~/.zshrc
    if [ -f ~/.config_local ]; then
      source ~/.config_local
    fi
    ```

---

## 2. Ferramentas de Produtividade

Já abordamos `fzf` e `direnv` em guias anteriores. Eles são peças fundamentais de um fluxo de trabalho produtivo.

- **`fzf` (Fuzzy Finder):** Use-o para buscar arquivos (`<leader>ff` com a nossa config), histórico de comandos (`Ctrl+r`), e muito mais. A velocidade com que você encontra o que precisa é transformadora.

- **`direnv` (Variáveis de Ambiente por Projeto):** Essencial para segurança e organização. Cada projeto tem seu próprio ambiente, e você nunca corre o risco de vazar segredos ou usar a versão errada de uma ferramenta.

Dominar essas ferramentas, em conjunto com o Neovim e um shell bem configurado, cria um ciclo de feedback positivo onde cada parte do seu ambiente de desenvolvimento potencializa a outra.

---

**Anterior:** [Neovim como um IDE com LSP](./06_neovim_as_ide.md) | **Próximo:** [Fim do Guia]