# 05. Gerenciamento de Plugins no Neovim (e Vim)

Plugins são a maneira como transformamos o Neovim (ou Vim) de um simples editor de texto em uma ferramenta de desenvolvimento poderosa e personalizada. Este guia explica como usar um gerenciador de plugins para instalar e configurar funcionalidades adicionais, com foco nas abordagens modernas do ecossistema Neovim (Lua).

## 1. Gerenciadores de Plugins

Um gerenciador de plugins automatiza a instalação, atualização e remoção de plugins. No ecossistema Neovim, o gerenciamento de plugins com **Lua** é a abordagem moderna e recomendada.

### `lazy.nvim` (Recomendado para Neovim)

O `lazy.nvim` é um gerenciador de plugins moderno, rápido e altamente configurável, escrito em Lua. Ele permite carregar plugins de forma assíncrona e sob demanda, otimizando o tempo de inicialização do Neovim.

#### Instalando `lazy.nvim`
Adicione o seguinte ao seu arquivo `~/.config/nvim/init.lua` (crie o arquivo e o diretório se não existirem):

```lua
-- ~/.config/nvim/init.lua

-- Instala o lazy.nvim (gerenciador de plugins)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Estrutura básica para definir seus plugins
local plugins = {
  -- Exemplo de plugin:
  -- { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
}

-- Carrega o lazy.nvim com a lista de plugins
require("lazy").setup(plugins, {})

-- Outras configurações do Neovim podem vir aqui
```

#### Comandos Básicos do `lazy.nvim`
*   Execute `:Lazy install` para instalar novos plugins.
*   Execute `:Lazy update` para atualizar todos os plugins.
*   Execute `:Lazy clean` para remover plugins que não estão mais na sua lista.
*   Execute `:Lazy health` para verificar a saúde dos seus plugins.

---

## 2. Plugins Essenciais para Começar

Aqui está uma lista de plugins fundamentais que adicionam funcionalidades básicas de um IDE moderno. Para cada um, mostraremos a instalação com `lazy.nvim`.

*   **Explorador de Arquivos: `nvim-tree.lua`**
    *   **Descrição:** Um explorador de arquivos em árvore moderno, escrito em Lua, com excelente integração com o Neovim.
    *   **Instalação (`lazy.nvim`):**
        ```lua
        {
          'nvim-tree/nvim-tree.lua',
          version = '*',
          lazy = false,
          dependencies = {
            'nvim-tree/nvim-web-devicons', -- opcional, para ícones
          },
          config = function()
            require("nvim-tree").setup {}
          end,
        }
        ```

*   **Linha de Status: `lualine.nvim`**
    *   **Descrição:** Uma linha de status leve e super configurável, escrita em Lua. Mostra informações cruciais em tempo real.
    *   **Instalação (`lazy.nvim`):**
        ```lua
        {
          'nvim-lualine/lualine.nvim',
          dependencies = { 'nvim-tree/nvim-web-devicons' },
          config = function()
            require('lualine').setup {
              -- ... (configurações opcionais)
            }
          end
        }
        ```

*   **Busca Rápida de Arquivos: `fzf` e `fzf.vim`**
    *   **Descrição:** Integração com o `fzf` para busca "fuzzy" de arquivos.
    *   **Instalação (`lazy.nvim`):**
        ```lua
        { 'junegunn/fzf', lazy = false, build = './install --all' },
        { 'junegunn/fzf.vim' }
        ```
    *   **Dependência Externa:** `fzf` é um programa de linha de comando que precisa ser instalado no seu sistema.

*   **Linting e Diagnósticos: `nvim-lspconfig`**
    *   **Descrição:** Configura o cliente LSP nativo do Neovim para analisar seu código em tempo real. Essencial para capturar bugs cedo.
    *   **Instalação (`lazy.nvim`):** `{ 'neovim/nvim-lspconfig' }`

*   **Comentários: `Comment.nvim`**
    *   **Descrição:** Um plugin de comentários para Neovim, escrito em Lua, que oferece atalhos para comentar/descomentar linhas e blocos de forma inteligente.
    *   **Instalação (`lazy.nvim`):** `{ 'numToStr/Comment.nvim', opts = {} }`

*   **Manipulação de Delimitadores: `nvim-surround`**
    *   **Descrição:** Uma implementação em Lua do plugin `vim-surround` para Neovim, que permite adicionar, remover e trocar delimitadores (parênteses, aspas, tags) com facilidade.
    *   **Instalação (`lazy.nvim`):** `{ 'kylechui/nvim-surround', version = '*', config = function() require('nvim-surround').setup() end }`

---

## 3. Guia de Instalação e Otimização do `fzf`

`fzf` é um "fuzzy finder" de linha de comando de uso geral, e é uma das ferramentas de produtividade mais impactantes que você pode adicionar ao seu arsenal.

### O que é um "Fuzzy Finder"?

Em vez de procurar por uma correspondência exata, um "fuzzy finder" permite que você digite alguns caracteres e ele encontrará todas as linhas que contêm esses caracteres, na ordem, mas não necessariamente juntos.

### Instruções de Instalação (Externa)

O `fzf` é um programa de linha de comando. Você deve instalá-lo no seu sistema operacional.

*   **Linux (com Gerenciador de Pacotes)**
    *   Debian / Ubuntu: `sudo apt install fzf`
    *   Fedora / RHEL: `sudo dnf install fzf`
    *   Arch Linux: `sudo pacman -S fzf`
*   **macOS (com Homebrew)**
    *   `brew install fzf`
*   **Método Universal (com Git)**
    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    ```

### Otimização: Usando `fzf` com `ripgrep`

Por padrão, o `fzf` (e o atalho `Ctrl+T`) usa o comando `find` para listar os arquivos. Para uma experiência mais rápida e inteligente (respeitando `.gitignore`), use `ripgrep`.

1.  **Instale `ripgrep`:**
    ```bash
    # Debian / Ubuntu
    sudo apt install ripgrep
    # macOS
    brew install ripgrep
    ```

2.  **Configure `fzf` para usar `ripgrep`:**
    Adicione a seguinte linha ao seu arquivo de configuração do shell (`~/.zshrc` ou `~/.bashrc`):
    ```bash
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    ```

---

## 4. Configurando Seus Plugins (em Lua)

A maioria dos plugins funciona "fora da caixa", mas o verdadeiro poder vem da customização. As configurações em Lua são geralmente colocadas dentro da seção `config = function() ... end` do plugin no `lazy.nvim`, ou em arquivos separados que são importados por `require()`.

### Exemplo de Configuração e Mapeamento
```lua
-- Exemplo de configuração do nvim-tree.lua (dentro da seção do plugin no lazy.nvim)
config = function()
  require("nvim-tree").setup {
    -- Adicione suas configurações aqui
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

-- Exemplo de mapeamento de teclas global em init.lua
vim.api.nvim_set_keymap(
  'n',
  '<Leader>e', -- Mapeia <Leader> + e
  ':NvimTreeToggle<CR>', -- Comando para alternar o nvim-tree
  { noremap = true, silent = true }
)

---

**Anterior:** [Neovim: Instalação e Filosofia](./04_neovim_installation_philosophy.md) | **Próximo:** [Transformando o Neovim em um IDE Completo (LSP Nativo e Lua)](./06_neovim_as_ide.md)
