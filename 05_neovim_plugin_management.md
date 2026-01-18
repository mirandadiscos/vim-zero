# 05. Gerenciamento de Plugins com `lazy.nvim`

Plugins são a forma como transformamos o Neovim de um simples editor de texto em um ambiente de desenvolvimento personalizado. Este guia foca no `lazy.nvim`, um gerenciador de plugins moderno, rápido e declarativo, escrito em Lua.

---

## 1. O que é `lazy.nvim` e por que usá-lo?

`lazy.nvim` é um gerenciador de plugins para Neovim que se destaca por sua **velocidade** e **carregamento preguiçoso (lazy loading)**. Em vez de carregar todos os seus plugins na inicialização, ele só carrega um plugin quando você realmente precisa dele (por exemplo, ao abrir um tipo de arquivo específico ou executar um comando).

**Vantagens:**
- **Inicialização Rápida:** Seu Neovim inicia quase instantaneamente.
- **Configuração Declarativa:** Você define sua lista de plugins em Lua, o que torna a configuração limpa e fácil de gerenciar.
- **Interface Gráfica:** Oferece uma interface para gerenciar, atualizar e depurar seus plugins.

---

## 2. Configuração Inicial do `lazy.nvim`

Para começar, você precisa de um arquivo `init.lua` em `~/.config/nvim/init.lua`. O código a seguir fará o "bootstrap" do `lazy.nvim`, instalando-o automaticamente na primeira vez que você iniciar o Neovim.

```lua
-- ~/.config/nvim/init.lua

-- 1. Instala o lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Define a lista de plugins
local plugins = {
  -- Coloque seus plugins aqui
  -- Exemplo: um tema
  { 'folke/tokyonight.nvim' },
}

-- 3. Carrega o lazy.nvim com os plugins
require("lazy").setup(plugins, {})

-- 4. Aplica o tema (exemplo)
vim.cmd.colorscheme 'tokyonight'
```

Ao salvar este arquivo e reiniciar o Neovim, o `lazy.nvim` será instalado. Você pode ver sua interface executando o comando `:Lazy`.

---

## 3. Adicionando Plugins Essenciais

Vamos construir uma configuração básica adicionando alguns plugins essenciais à nossa lista.

### Tema: `tokyonight.nvim`
Um bom tema torna o código mais legível e agradável de se ver.
```lua
{ 'folke/tokyonight.nvim' }
```

### Explorador de Arquivos: `nvim-tree.lua`
Um explorador de arquivos em árvore, essencial para navegar pela estrutura do projeto.
```lua
{
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Para ícones
  config = function()
    require('nvim-tree').setup {}
  end,
}
```
Para abrir e fechar o `nvim-tree`, você pode criar um atalho. Adicione o seguinte ao seu `init.lua`:
```lua
-- Atalho para abrir/fechar o nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true,
})
```

### Linha de Status: `lualine.nvim`
Uma linha de status informativa que mostra o modo atual, branch do Git, nome do arquivo, etc.
```lua
{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'tokyonight' -- para combinar com o tema
      }
    }
  end
}
```

### Busca Rápida de Arquivos: `telescope.nvim`
`telescope.nvim` é um "fuzzy finder" extremamente poderoso que permite buscar arquivos, texto, comandos, e muito mais. Ele é o sucessor espiritual do `fzf.vim` no ecossistema Lua.
```lua
{
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' }
}
```
**Dependência Externa:** Para melhor desempenho, instale `ripgrep` no seu sistema: `sudo apt install ripgrep`.

Atalhos para o Telescope:
```lua
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- Encontrar arquivos
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})  -- Buscar texto no projeto
```

---

## 4. Exemplo Completo de `init.lua`

Aqui está um arquivo `init.lua` completo que você pode usar como ponto de partida.

```lua
-- ~/.config/nvim/init.lua

-- Define o líder (leader)
vim.g.mapleader = ' '

-- Instala o lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lista de plugins
local plugins = {
  -- Tema
  { 'folke/tokyonight.nvim' },

  -- Explorador de Arquivos
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {}
    end,
  },

  -- Linha de Status
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight'
        }
      }
    end
  },

  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  }
}

-- Carrega o lazy.nvim
require("lazy").setup(plugins, {})

-- Aplica o tema
vim.cmd.colorscheme 'tokyonight'

-- Atalhos (Keymaps)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Configurações básicas (mesmas do guia anterior)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
```

Depois de salvar este arquivo, reinicie o Neovim e execute `:Lazy install` para instalar todos os plugins.

---

**Anterior:** [Instalação e Filosofia do Neovim](./04_neovim_installation_philosophy.md) | **Próximo:** [Neovim como um IDE com LSP](./06_neovim_as_ide.md)