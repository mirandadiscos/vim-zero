# 06. Neovim como um IDE com LSP

Este guia mostra como transformar o Neovim em um ambiente de desenvolvimento integrado (IDE) completo, usando seu cliente **Language Server Protocol (LSP)** nativo. Isso proporciona funcionalidades como autocompletar, diagnósticos de código e navegação inteligente de forma leve e performática.

---

## 1. O que é o LSP?

O LSP é um padrão que permite que editores de texto (como o Neovim) se comuniquem com "servidores de linguagem".

- **Language Server:** Um programa que "entende" uma linguagem específica (ex: `pyright` para Python, `tsserver` para TypeScript). Ele analisa seu código e fornece inteligência.
- **Cliente LSP (Neovim):** O Neovim possui um cliente LSP embutido, que se conecta a esses servidores para obter informações e exibir no editor.

O plugin `nvim-lspconfig` simplifica a configuração desses servidores.

---

## 2. Plugins para uma Experiência IDE

Vamos adicionar os plugins necessários para LSP, autocompletar e snippets ao nosso `init.lua`, usando o `lazy.nvim`.

```lua
-- Em sua lista de plugins no init.lua
{
  -- Essencial para a configuração do LSP
  'neovim/nvim-lspconfig',

  -- Engine de autocompletar
  'hrsh7th/nvim-cmp',

  -- Fontes (sources) para o nvim-cmp
  'hrsh7th/cmp-nvim-lsp', -- Sugestões do LSP
  'hrsh7th/cmp-buffer',   -- Sugestões do buffer atual
  'hrsh7th/cmp-path',     -- Sugestões de caminhos de arquivo

  -- Para snippets
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip', -- Integração de snippets com o cmp
}
```

---

## 3. Instalando os Language Servers

O Neovim precisa dos servidores de linguagem para as linguagens que você usa. Eles devem ser instalados no seu sistema.

**Use o `mason.nvim` para gerenciar os LSPs facilmente.**
`mason.nvim` é um plugin que gerencia a instalação e atualização de LSPs, formatadores e linters.

Adicione `mason.nvim` e `mason-lspconfig.nvim` aos seus plugins:
```lua
{ 'williamboman/mason.nvim' },
{ 'williamboman/mason-lspconfig.nvim' },
```

Agora, você pode instalar LSPs com o comando `:Mason`. Por exemplo, para instalar o servidor de Python:
1.  Execute `:Mason`.
2.  Pressione `i` para instalar.
3.  Digite `pyright` e pressione Enter.

**Exemplos de LSPs populares:**
- **Python:** `pyright`
- **JavaScript/TypeScript:** `tsserver`
- **Lua:** `lua-language-server`
- **HTML/CSS/JSON:** `vscode-langservers-extracted`
- **Shell:** `bash-language-server`

---

## 4. Configurando o `init.lua`

Agora, vamos configurar os plugins e o LSP no seu `init.lua`.

```lua
-- ~/.config/nvim/init.lua

-- ... (bootstrap do lazy.nvim e lista de plugins, incluindo os de LSP/cmp)

-- [[ Configuração do LSP ]]
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Mapeamentos de teclas do LSP (coloque isso em algum lugar após carregar os plugins)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

-- Configura o mason para usar os LSPs instalados
mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
}

-- [[ Configuração do Autocompletar (nvim-cmp) ]]
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
}
```

---

## 5. Exemplo Completo do `init.lua` (Até Agora)

Este `init.lua` combina tudo o que vimos até agora, dando a você um ponto de partida sólido para um IDE.

```lua
-- ~/.config/nvim/init.lua
vim.g.mapleader = ' '

-- Bootstrap do lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git","clone","--filter=blob:none","https://github.com/folke/lazy.nvim.git","--branch=stable",lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Lista de plugins
local plugins = {
  { 'folke/tokyonight.nvim' },
  { 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function() require('nvim-tree').setup {} end },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function() require('lualine').setup { options = { theme = 'tokyonight' } } end },
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
}

require("lazy").setup(plugins, {})
vim.cmd.colorscheme 'tokyonight'

-- Atalhos
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Configurações
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Configuração do LSP e CMP
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

mason_lspconfig.setup_handlers { function(server_name) lspconfig[server_name].setup {} end }

cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fb) if cmp.visible() then cmp.select_next_item() elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump() else fb() end end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fb) if cmp.visible() then cmp.select_prev_item() elseif luasnip.jumpable(-1) then luasnip.jump(-1) else fb() end end, {'i', 's'}),
  }),
  sources = {{ name = 'nvim_lsp' }, { name = 'luasnip' }, { name = 'buffer' }, { name = 'path' }},
}
```

---

**Anterior:** [Gerenciamento de Plugins com lazy.nvim](./05_neovim_plugin_management.md) | **Próximo:** [Ferramentas de Produtividade e Dotfiles](./07_productivity_dotfiles.md)