# 07. Produtividade e Dotfiles

Este guia aborda duas áreas avançadas para aumentar sua produtividade: o gerenciamento de suas configurações (dotfiles) com Git e a integração do Neovim com assistentes de IA como o Gemini.

## 1. Gerenciando Dotfiles com Git e GitHub

"Dotfiles" são os arquivos de configuração no seu diretório home que começam com um ponto (ex: `~/.vimrc`, `~/.zshrc`, `~/.gitconfig`). Eles contêm a "alma" do seu ambiente de desenvolvimento personalizado. Gerenciá-los com Git é uma das melhores práticas que você pode adotar.

### a) Por que Versionar seus Dotfiles?

1.  **Backup:** Se você perder sua máquina, pode recriar seu ambiente perfeitamente configurado em minutos.
2.  **Portabilidade:** Clone seus dotfiles em qualquer nova máquina (ou servidor remoto) e tenha seu ambiente de trabalho instantaneamente.
3.  **Histórico:** Fez uma alteração que quebrou tudo? `git revert` é seu melhor amigo. Você pode experimentar novas configurações com segurança.
4.  **Fonte Única da Verdade:** Seu ambiente de desenvolvimento se torna consistente em todas as máquinas que você usa.

### b) O Método do Repositório "Bare"

A maneira mais elegante e menos intrusiva de gerenciar dotfiles é usar um **repositório Git "bare" (nu)**. Isso permite que você versione arquivos diretamente no seu diretório `home` sem criar um repositório Git na raiz (`~/`), o que causaria conflitos com todos os outros repositórios Git em subdiretórios.

### c) Guia Passo a Passo

1.  **Configuração Inicial**
    *   Crie o repositório "bare": `git init --bare $HOME/.dotfiles`
    *   Crie um alias para o comando `dotgit` no seu `.zshrc` ou `.bashrc`:
        ```bash
        alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
        ```
    *   Recarregue seu shell: `source ~/.zshrc`

2.  **Primeiro Commit**
    *   Configure o repositório para não mostrar arquivos não rastreados: `dotgit config --local status.showUntrackedFiles no`
    *   Adicione seus dotfiles:
        ```bash
        dotgit add ~/.vimrc # ou ~/.config/nvim/init.lua para Neovim
        dotgit add ~/.zshrc
        dotgit add ~/.gitconfig
        ```
    *   Faça o commit: `dotgit commit -m "Initial dotfiles commit"`

3.  **Conectando ao GitHub**
    *   Crie um novo repositório **privado** no GitHub chamado `dotfiles`.
    *   Adicione o remote: `dotgit remote add origin git@github.com:SEU_USUARIO/dotfiles.git`
    *   Envie seus dotfiles: `dotgit push -u origin master`

4.  **Clonando em uma Nova Máquina**
    *   Clone o repositório: `git clone --bare git@github.com:SEU_USUARIO/dotfiles.git $HOME/.dotfiles`
    *   Defina o alias `dotgit` no `.bashrc` ou `.zshrc` da nova máquina e recarregue o shell.
    *   Faça o "checkout" dos seus arquivos: `dotgit checkout`
    *   Se houver conflitos com arquivos existentes, faça um backup deles e tente o checkout novamente.

---

## 2. Usando Vim/Neovim + Gemini para Superprodutividade

A combinação de um editor de texto eficiente como o Neovim e um assistente de IA poderoso como o Gemini, diretamente na linha de comando, cria um fluxo de trabalho de desenvolvimento extremamente rápido e focado.

### a) O Fluxo de Trabalho Básico: Lado a Lado

A maneira mais simples e eficaz de usar o Neovim e o Gemini juntos é em um ambiente com painéis de terminal (splits) usando um emulador de terminal moderno como `Windows Terminal`, `iTerm2` ou `tmux`.

### b) Cenário 1: Gerar e Colar
Você precisa de uma nova função, um teste unitário ou um bloco de código repetitivo (boilerplate).

1.  **Peça ao Gemini:** No painel do Gemini, escreva um prompt claro.
2.  **Copie o Código:** Copie o bloco de código gerado pelo Gemini.
3.  **Cole no Neovim:** No painel do Neovim, mova o cursor para onde você quer o código e cole-o (usando `p` no modo normal).

### c) Cenário 2: Copiar, Explicar e Refatorar
Você encontra um trecho de código legado ou complexo que não entende completamente.

1.  **Copie do Neovim:** Selecione o bloco de código no Neovim (usando o Modo Visual) e copie-o (`y`).
2.  **Peça ao Gemini:** No painel do Gemini, cole o código e peça ajuda.
3.  **Copie a Nova Versão:** Copie o código refatorado do Gemini.
4.  **Substitua no Neovim:** No Neovim, selecione o bloco de código antigo novamente e cole a nova versão, substituindo-o.

### d) Integração Avançada: Criando um Comando no Neovim

Você pode criar atalhos no seu `init.lua` para enviar código diretamente do Neovim para o Gemini CLI.

**Exemplo de Configuração no `init.lua`:**
```lua
-- Mapeia <Leader>ge (g de gemini, e de explain) no Modo Visual
-- para enviar o texto selecionado para o Gemini CLI.
vim.api.nvim_set_keymap(
  'v',
  '<Leader>ge',
  ':!gemini "Explique este código:" "$(xclip -o)"\n',
  { noremap = true, silent = true }
)
```

**Como Funciona:**
*   `"$(xclip -o)"` é um truque para sistemas Linux com `xclip` instalado. Ele pega o conteúdo da área de transferência e o insere no comando.

**Uso:**
1.  Selecione um bloco de código no Neovim (Modo Visual).
2.  Pressione `\` + `g` + `e`.
3.  O editor executará o comando no shell, e a resposta do Gemini aparecerá no seu terminal.

### e) Boas Práticas

*   **Prompts Claros:** A qualidade da saída do Gemini depende da qualidade da sua entrada.
*   **Use Registros:** Copie diferentes trechos de código para registros nomeados no Neovim (ex: `"ayy` para copiar uma linha para o registro `a`, `"byy` para o registro `b`) para poder fazer várias perguntas ao Gemini sem perder o que copiou.
*   **Confie, mas Verifique:** Sempre revise e entenda o código gerado pela IA antes de integrá-lo ao seu projeto.

---

**Anterior:** [Transformando o Neovim em um IDE Completo (LSP Nativo e Lua)](./06_neovim_as_ide.md)