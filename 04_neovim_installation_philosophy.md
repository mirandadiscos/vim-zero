# Guia: Vim vs. Neovim (Nvim)

Neovim (`nvim`) é um **fork** do Vim que foi refatorado para ser mais moderno, extensível e mantido pela comunidade. Ele compartilha a maior parte da filosofia e dos comandos do Vim, mas se diferencia em áreas-chave que o tornam uma opção atraente para muitos desenvolvedores.

Este guia detalha as diferenças, vantagens e como migrar.

## Comparativo: Vim vs. Neovim

| Funcionalidade              | Vim (Tradicional)                                                              | Neovim (Nvim)                                                                                             | Impacto Prático                                                                                                     |
| --------------------------- | ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Configuração**            | Apenas **Vimscript** (`.vimrc`).                                               | **Lua** como cidadão de primeira classe, além do Vimscript (`init.lua`).                                  | Lua é uma linguagem de script mais rápida, moderna e fácil de aprender, permitindo configurações mais complexas e limpas. |
| **Suporte a LSP**           | Não possui. Requer um plugin pesado como o `coc.nvim`.                         | **Cliente LSP nativo e integrado**.                                                                       | A experiência de IDE (autocompletar, etc.) é mais leve, rápida e integrada ao núcleo do editor.                     |
| **Plugins**                 | Ecossistema maduro, mas focado em Vimscript.                                   | Ecossistema moderno e crescente focado em **Lua**.                                                        | Plugins em Lua aproveitam a velocidade e as APIs do Neovim, resultando em melhor desempenho.                        |
| **Desenvolvimento**         | Liderado por Bram Moolenaar, com um ritmo mais lento e conservador.            | **Impulsionado pela comunidade no GitHub**, com desenvolvimento mais rápido e transparente.               | Novos recursos e correções chegam ao Neovim com mais frequência.                                                    |
| **Terminal Embutido**       | Possui (`:terminal`), mas com algumas limitações.                              | **Terminal `libvterm` completo** e totalmente integrado.                                                  | O terminal do Neovim é mais robusto e se comporta mais como um emulador de terminal independente.                  |
| **Padrões (Defaults)**      | Mantém padrões antigos por retrocompatibilidade.                               | **Padrões mais modernos** e sensatos para novos usuários (ex: `mouse=a` ativado, `set inccommand=split`). | Neovim se parece e se comporta mais como um editor moderno "fora da caixa".                                         |

## Para Quem é o Neovim?

*   **Para o Iniciante Curioso:** Se você está começando com o "universo Vim" agora, começar com Neovim pode ser mais fácil, pois seus padrões são mais amigáveis e o ecossistema de plugins Lua é muito ativo.
*   **Para o Usuário de Vim que Busca Desempenho:** Se sua configuração do Vim com muitos plugins está se tornando lenta, especialmente com `coc.nvim`, migrar para Neovim com LSP nativo pode trazer um ganho de performance significativo.
*   **Para o Entusiasta que Gosta de Configurar:** Se você gosta de "tinkar" e otimizar seu editor e quer usar uma linguagem moderna como Lua para isso, o Neovim é o seu playground.

> **Fique com o Vim se:** Você tem uma configuração estável da qual depende, prefere a filosofia de desenvolvimento mais lenta e cautelosa, ou trabalha em sistemas muito antigos onde o Neovim pode não estar disponível.

---

## Guia de Migração: do Vim para o Neovim

Migrar pode ser tão simples ou tão complexo quanto você quiser.

### Passo 1: O Caminho Fácil (Compatibilidade)

O Neovim foi projetado para ser compatível com o Vim. Você pode fazer o Neovim usar seu `.vimrc` existente sem nenhuma alteração.

1.  **Instale o Neovim:**
    ```bash
    # Exemplo para Ubuntu
    sudo apt install neovim
    # Exemplo para macOS
    brew install neovim
    ```
2.  **Crie a pasta de configuração do Neovim:**
    ```bash
    mkdir -p ~/.config/nvim
    ```
3.  **Crie um link simbólico para seu `.vimrc`:**
    O Neovim procura por um arquivo `init.vim` dentro de `~/.config/nvim`.
    ```bash
    ln -s ~/.vimrc ~/.config/nvim/init.vim
    ```
Pronto! Agora, ao executar `nvim`, ele usará sua configuração do Vim. A maioria dos seus plugins, incluindo `vim-plug` e `coc.nvim`, deve funcionar normalmente.

### Passo 2: A Migração Completa (O "Modo Neovim")

A verdadeira vantagem do Neovim é usar seu ecossistema Lua. Isso envolve uma migração mais completa.

1.  **Adote um Gerenciador de Plugins em Lua:**
    Em vez do `vim-plug`, a comunidade Neovim usa gerenciadores escritos em Lua. O mais popular atualmente é o **[lazy.nvim](https://github.com/folke/lazy.nvim)** (substituindo o antigo `packer.nvim`). Eles são mais rápidos e se integram melhor com configurações em Lua.

2.  **Crie um arquivo `init.lua`:**
    Em vez de `init.vim`, a configuração nativa do Neovim é feita em `~/.config/nvim/init.lua`. Aqui você escreverá suas configurações usando a sintaxe Lua.

**Exemplo de como se parece uma configuração em `init.lua` com `lazy.nvim`:**
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

-- Lista de plugins
local plugins = {
  -- Essencial: LSP, autocompletar, etc.
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  
  -- Tema (exemplo)
  { 'folke/tokyonight.nvim' },
}

-- Carrega o lazy.nvim com a lista de plugins
require("lazy").setup(plugins, {})

-- Configurações adicionais...
vim.opt.number = true -- Mostra números de linha
```

3.  **Use o LSP Nativo:**
    Em vez de `coc.nvim`, você usaria o `nvim-lspconfig` para configurar os language servers. A configuração é feita em Lua e é considerada mais leve e performática.

---

**Anterior:** [Introdução e Comandos Essenciais (Vim e Neovim)](./03_vim_neovim_intro_basics.md) | **Próximo:** [Gerenciamento de Plugins no Neovim (e Vim)](./05_neovim_plugin_management.md)