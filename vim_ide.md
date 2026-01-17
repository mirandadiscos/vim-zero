# Guia: Transformando o Vim em um IDE com CoC

Este guia detalha como transformar o Vim em um ambiente de desenvolvimento integrado (IDE) moderno usando o plugin `coc.nvim` (Conqueror of Completion) e outros plugins essenciais.

## Roteiro de Configuração
1.  **Instalar os Plugins:** Adicionar a lista de plugins ao seu `.vimrc` e instalá-los com `vim-plug`.
2.  **Entender a Arquitetura (LSP):** Compreender o que é um Language Server e como o `coc.nvim` o utiliza.
3.  **Instalar Language Servers:** Instalar os "servidores" específicos para as linguagens que você usa (ex: `pyright` para Python).
4.  **Instalar Extensões do CoC:** Instalar as "pontes" entre o `coc.nvim` e os language servers.
5.  **Configurar o `.vimrc`:** Adicionar mapeamentos de teclas e configurações para uma experiência fluida.
6.  **(Opcional) Configurar o Debugger:** Adicionar e configurar o `vimspector` para depuração interativa.

---

## 1. A Stack de Plugins para uma Experiência IDE

Adicione esta lista ao seu `~/.vimrc` e execute `:PlugInstall`.

```vim
call plug#begin('~/.vim/plugged')

" 1. ESSENCIAL: INTELIGÊNCIA DE CÓDIGO (LSP)
" Requer Node.js >= 16
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 2. EXPLORADOR DE ARQUIVOS E UI
" Use UMA das duas opções de explorador de arquivos:
" Plug 'preservim/nerdtree' " O clássico.
Plug 'neoclide/coc-explorer', {'branch': 'release'} " Alternativa que se integra melhor com CoC.

Plug 'ryanoasis/vim-devicons' " Ícones para a UI
Plug 'vim-airline/vim-airline' " Statusline bonita
Plug 'vim-airline/vim-airline-themes'

" 3. BUSCA RÁPIDA DE ARQUIVOS
Plug 'junegunn/fzf.vim'

" 4. INTEGRAÇÃO COM GIT
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 5. SNIPPETS DE CÓDIGO
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc-snippets' " Para integrar snippets com o autocompletar do CoC

" 6. DEBUGGING
Plug 'puremourning/vimspector'

call plug#end()
```

---

## 2. Entendendo a Arquitetura: LSP e `coc.nvim`

O **Language Server Protocol (LSP)** é um protocolo criado pela Microsoft que padroniza a comunicação entre um editor de texto e um "servidor de linguagem".

*   **Language Server (o Cérebro):** É um programa que entende uma linguagem específica (ex: `pyright` para Python). Ele analisa o código e fornece informações como diagnósticos, definições de funções e sugestões de autocompletar.
*   **Cliente LSP (o Mensageiro):** É um plugin no seu editor (neste caso, o `coc.nvim`) que se comunica com o Language Server e exibe as informações recebidas na interface do Vim.

O `coc.nvim` é um **cliente** LSP. Ele precisa que o **servidor** da linguagem esteja instalado no seu sistema para funcionar.

## 3. Instalando Language Servers

Você deve instalar os servidores para as linguagens que utiliza. A instalação é feita pelo terminal, usando o gerenciador de pacotes da linguagem.

*   **Para Python (recomendado: `pyright`):**
    ```bash
    pip install "python-lsp-server[all]"
    ```

*   **Para JavaScript/TypeScript (`typescript-language-server`):**
    ```bash
    npm install -g typescript-language-server typescript
    ```

*   **Para HTML, CSS, JSON:**
    ```bash
    npm install -g vscode-langservers-extracted
    ```
Para outras linguagens, procure por "LSP" (ex: `rust analyzer`, `gopls`).

## 4. Instalando Extensões do CoC

Agora, de dentro do Vim, instale as extensões do `coc.nvim` que farão a ponte com os servidores que você acabou de instalar.

```vim
" Para Python
:CocInstall coc-pyright

" Para JavaScript/TypeScript
:CocInstall coc-tsserver

" Para HTML, CSS, JSON, etc.
:CocInstall coc-html coc-css coc-json
```

---

## 5. Configurando o `.vimrc` para o CoC

Adicione estas configurações ao seu `.vimrc` para ter uma experiência de IDE completa com atalhos convenientes.

```vim
" Melhor experiência de UI para o autocompletar
set completeopt=menuone,noinsert,noselect

" Configuração de Tab para autocompletar
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : coc#pum#prev(1)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Confirma a seleção com Enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" --- Mapeamentos para funcionalidades do LSP (Modo Normal) ---

" Ir para a definição de uma função/variável
nmap <silent> gd <Plug>(coc-definition)
" Ir para a definição do tipo
nmap <silent> gy <Plug>(coc-type-definition)
" Ir para a implementação
nmap <silent> gi <Plug>(coc-implementation)
" Mostrar todas as referências
nmap <silent> gr <Plug>(coc-references)
" Mostrar documentação ao passar o mouse (hover)
nmap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Renomear símbolo
nmap <leader>rn <Plug>(coc-rename)

" Corrigir erro automaticamente
nmap <leader>qf <Plug>(coc-fix-current)

" Atalho para o explorador de arquivos do CoC
nnoremap <silent> <space>e :CocCommand explorer<CR>
```

---

## 6. Configurando o Debugger (`vimspector`)

O `vimspector` usa o **Debug Adapter Protocol (DAP)**, o mesmo que o VSCode, para se comunicar com depuradores. A configuração é feita em duas partes:

1.  **Instalar "Gadgets":** São os adaptadores de depuração. Você os instala com um comando do `vimspector`. Por exemplo, para Node.js:
    ```vim
    :VimspectorInstall debugpy
    ```

2.  **Criar um arquivo `.vimspector.json`:** Na raiz do seu projeto, crie este arquivo para definir como o `vimspector` deve lançar o depurador.

**Exemplo de `.vimspector.json` para Node.js:**
```json
{
  "configurations": {
    "launch": {
      "adapter": "debugpy",
      "configuration": {
        "request": "launch",
        "protocol": "auto",
        "program": "${file}",
        "stopOnEntry": true,
        "console": "integratedTerminal"
      }
    }
  }
}
```

### Comandos Básicos do `vimspector`
*   **`<F5>`** (mapeamento comum): Iniciar a depuração (`:VimspectorLaunch`).
*   **`<F9>`** (mapeamento comum): Alternar um breakpoint (`:VimspectorToggleBreakpoint`).
*   **`<F10>`**: Step Over (`:VimspectorStepOver`).
*   **`<F11>`**: Step Into (`:VimspectorStepInto`).

Adicione os mapeamentos de teclas ao seu `.vimrc`:
```vim
nnoremap <F5> :VimspectorLaunch<CR>
nnoremap <F9> :VimspectorToggleBreakpoint<CR>
nnoremap <F10> :VimspectorStepOver<CR>
nnoremap <F11> :VimspectorStepInto<CR>
```

---

**Anterior:** [Guia de Instalação e Otimização do `fzf`](./fzf_installation.md) | **Próximo:** [Guia: Vim vs. Neovim (Nvim)](./neovim_explained.md)
Com isso, você tem um fluxo de trabalho completo de desenvolvimento e depuração diretamente no Vim.