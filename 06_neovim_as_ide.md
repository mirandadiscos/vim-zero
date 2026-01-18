# Guia: Transformando o Neovim em um IDE Completo (LSP Nativo e Lua)

Este guia detalha como transformar o Neovim em um ambiente de desenvolvimento integrado (IDE) moderno, aproveitando seu cliente LSP nativo e a configuração em Lua. Embora o `coc.nvim` seja uma opção poderosa para usuários de Vim, o Neovim oferece uma experiência mais integrada e performática com sua abordagem nativa.

## Roteiro de Configuração
1.  **Instalar e Configurar Gerenciador de Plugins (lazy.nvim):** Adicionar a estrutura básica do `lazy.nvim` ao seu `init.lua`.
2.  **Instalar Plugins Essenciais:** Adicionar plugins para explorador de arquivos, linha de status, etc., utilizando o `lazy.nvim`.
3.  **Entender a Arquitetura (LSP Nativo):** Compreender o que é um Language Server e como o Neovim o utiliza com `nvim-lspconfig`.
4.  **Instalar Language Servers:** Instalar os "servidores" específicos para as linguagens que você usa (ex: `pyright` para Python).
5.  **Configurar o Neovim LSP (Lua):** Configurar `nvim-lspconfig` e `nvim-cmp` para autocompletar, diagnósticos e outras funcionalidades LSP.
6.  **(Opcional) Configurar o Debugger (nvim-dap):** Adicionar e configurar o `nvim-dap` para depuração interativa.

---

## 1. A Stack de Plugins Essenciais (com `lazy.nvim`)

Para uma experiência de IDE completa no Neovim, recomendamos os seguintes plugins. Adicione-os à sua tabela `plugins` no `init.lua` (conforme configurado em `vim_plugins.md`).

```lua
-- ~/.config/nvim/init.lua (trecho)

local plugins = {
  -- Gerenciador de LSP: conecta o Neovim aos Language Servers
  { 'neovim/nvim-lspconfig' },

  -- Autocompletar: essencial para a experiência de IDE
  { 'hrsh7th/nvim-cmp' },             -- Engine de autocompletar
  { 'hrsh7th/cmp-nvim-lsp' },         -- Fonte para LSP
  { 'saadparwaiz1/cmp_luasnip' },     -- Fonte para snippets
  { 'L3MON4D3/LuaSnip' },             -- Engine de snippets

  -- Explorador de Arquivos
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- ícones para arquivos
    },
    config = function()
      require("nvim-tree").setup {
        -- Adicione suas configurações do nvim-tree aqui
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true, -- Mostrar arquivos ocultos
        },
      }
    end,
  },

  -- Linha de Status (statusline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Para ícones na statusline
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto', -- ou 'tokyonight', 'dracula', etc.
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end
  },

  -- Integração com Git
  { 'tpope/vim-fugitive' }, -- Comandos Git dentro do Neovim
  { 'airblade/vim-gitgutter' }, -- Indicadores de alteração Git na barra lateral

  -- Comentários inteligentes
  { 'numToStr/Comment.nvim', opts = {} },

  -- Manipulação de delimitadores (parênteses, aspas, etc.)
  {
    'kylechui/nvim-surround',
    version = '*', -- Use `main` for latest version or `*` for latest stable release
    config = function()
        require('nvim-surround').setup()
    end
  },

  -- Debugger
  { 'mfussenegger/nvim-dap' }, -- Debug Adapter Protocol client
  { 'rcarriga/nvim-dap-ui' },   -- Interface de usuário para o nvim-dap
}
-- O restante da sua configuração lazy.nvim.
```

---

## 2. Entendendo a Arquitetura: LSP Nativo do Neovim

O **Language Server Protocol (LSP)** é um protocolo que padroniza a comunicação entre um editor e um "servidor de linguagem". O Neovim possui um cliente LSP nativo e integrado, o que significa que ele pode se comunicar diretamente com esses servidores de forma leve e performática, sem a necessidade de plugins intermediários pesados como o `coc.nvim`.

*   **Language Server (o Cérebro):** É um programa que entende uma linguagem específica (ex: `pyright` para Python). Ele analisa o código e fornece informações como diagnósticos, definições de funções e sugestões de autocompletar.
*   **Cliente LSP Nativo do Neovim:** O próprio Neovim atua como cliente, utilizando o módulo `vim.lsp` para interagir com os Language Servers. O plugin `nvim-lspconfig` simplifica a configuração desses servidores.

## 3. Instalando Language Servers

Você deve instalar os servidores para as linguagens que utiliza. A instalação é feita pelo terminal, usando o gerenciador de pacotes da linguagem.

*   **Para Python (recomendado: `pyright`):**
    ```bash
    pip install "python-lsp-server[all]"
    # ou pip install pyright (servidor LSP mais focado em Type Checking)
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

## 4. Configurando o Neovim LSP (Lua)

Com os Language Servers instalados no seu sistema, agora você configurará o `nvim-lspconfig` no seu `init.lua` para que o Neovim saiba como se comunicar com eles.

```lua
-- ~/.config/nvim/init.lua (trecho)

-- Configurações básicas do LSP
local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- Mapeamentos de teclas para LSP
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format Buffer' })

-- Configura o nvim-cmp para autocompletar
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For snippets
  }, {
    { name = 'buffer' },
  })
})

-- Configurações para Language Servers específicos
-- Exemplo para Python com pyright
lspconfig.pyright.setup {
  on_attach = function(client, bufnr)
    -- Opcional: Configurações adicionais quando o servidor é anexado
  end,
  settings = {
    python = {
      analysis = {
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}

-- Exemplo para TypeScript/JavaScript
lspconfig.tsserver.setup {
  on_attach = function(client, bufnr) end,
}

-- Exemplo para HTML, CSS, JSON
lspconfig.html.setup {}
lspconfig.cssls.setup {}
lspconfig.jsonls.setup {}

-- Configuração de Diagnósticos (avisos e erros)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Mapeamentos para navegar pelos diagnósticos
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics quickfix list' })
```

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

**Anterior:** [Gerenciamento de Plugins no Neovim (e Vim)](./05_neovim_plugin_management.md) | **Próximo:** [Produtividade e Dotfiles](./07_productivity_dotfiles.md)
