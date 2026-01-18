# 04. Instalação e Filosofia do Neovim

Neovim é uma evolução do editor Vim, refatorado para ser mais moderno, extensível e mantido pela comunidade. Ele preserva a eficiência da edição modal, mas com melhorias significativas "sob o capô".

---

## 1. Por que escolher Neovim?

| Vantagem | Descrição |
| :--- | :--- |
| **Configuração em Lua** | Neovim usa **Lua** como linguagem de primeira classe para configuração (`init.lua`). Lua é uma linguagem de script mais rápida, moderna e fácil de aprender que Vimscript, permitindo configurações mais limpas e poderosas. |
| **LSP Nativo** | Possui um **cliente de Language Server Protocol (LSP) integrado**. Isso significa que funcionalidades de IDE (autocompletar, ir para definição, diagnósticos) são mais leves e rápidas do que em Vim, que depende de plugins pesados como `coc.nvim`. |
| **Plugins Modernos** | O ecossistema de plugins em Lua é extremamente ativo e crescente. Plugins escritos em Lua aproveitam a velocidade e as APIs modernas do Neovim, resultando em melhor desempenho. |
| **Desenvolvimento Aberto** | O desenvolvimento é impulsionado pela comunidade no GitHub, o que o torna mais rápido, transparente e alinhado com as necessidades dos desenvolvedores modernos. |
| **Padrões Sensatos** | Neovim vem com padrões mais modernos "fora da caixa". Por exemplo, a integração com a área de transferência do sistema e o uso do mouse já vêm habilitados, facilitando a vida de quem está começando. |

Em resumo, Neovim oferece a mesma eficiência de edição do Vim, mas com uma base mais sólida para o futuro, melhor desempenho e uma experiência de configuração mais agradável.

---

## 2. Instalação do Neovim

### Linux (via Gerenciador de Pacotes)

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim

# Fedora
sudo dnf install neovim
```

### macOS (via Homebrew)

```bash
brew install neovim
```

### Windows (via Scoop ou Chocolatey)

**Com Scoop (recomendado):**
```powershell
scoop install neovim
```

**Com Chocolatey:**
```powershell
choco install neovim
```

### Verificando a Instalação

Após a instalação, abra seu terminal e digite `nvim`. Se o editor abrir, a instalação foi bem-sucedida.

---

## 3. Migrando do Vim para o Neovim

A migração pode ser feita de forma gradual.

### Passo 1: O Caminho Fácil (Compatibilidade Total)

Neovim foi projetado para ser compatível com as configurações do Vim. Você pode fazer o Neovim usar seu `.vimrc` existente sem nenhuma alteração.

1.  Crie a pasta de configuração do Neovim (se ela não existir):
    ```bash
    mkdir -p ~/.config/nvim
    ```

2.  Crie um arquivo chamado `init.vim` dentro dessa pasta e importe seu `.vimrc`:
    ```vim
    " ~/.config/nvim/init.vim
    source ~/.vimrc
    ```

Pronto! Ao executar `nvim`, ele usará sua configuração do Vim. A maioria dos seus plugins deve funcionar normalmente.

### Passo 2: A Migração Completa (Abraçando o Ecossistema Lua)

A verdadeira vantagem do Neovim é usar seu ecossistema Lua. Isso envolve reescrever sua configuração em `init.lua`.

1.  **Crie seu arquivo `init.lua`:**
    O arquivo principal de configuração do Neovim é o `~/.config/nvim/init.lua`.

2.  **Adote um Gerenciador de Plugins em Lua:**
    Em vez de `vim-plug`, a comunidade Neovim usa gerenciadores escritos em Lua, como o **[lazy.nvim](https.github.com/folke/lazy.nvim)**. Eles são mais rápidos e se integram perfeitamente com configurações em Lua.

3.  **Traduza suas Configurações:**
    Converta suas configurações do `.vimrc` (Vimscript) para `init.lua` (Lua).

    **Exemplo de Tradução:**

    | Vimscript (`.vimrc`) | Lua (`init.lua`) |
    | :--- | :--- |
    | `set number` | `vim.opt.number = true` |
    | `set tabstop=2` | `vim.opt.tabstop = 2` |
    | `let g:mapleader = ' '` | `vim.g.mapleader = ' '` |

O guia a seguir sobre gerenciamento de plugins mostrará na prática como construir um `init.lua` do zero.

---

**Anterior:** [Introdução ao Vim e Neovim](./03_vim_neovim_intro_basics.md) | **Próximo:** [Gerenciamento de Plugins com lazy.nvim](./05_neovim_plugin_management.md)