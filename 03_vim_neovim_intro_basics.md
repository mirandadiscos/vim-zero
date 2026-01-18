# 03. Introdução ao Neovim e à Edição Modal

Este guia é seu ponto de partida para o mundo da edição modal com Neovim. Ele explica a filosofia por trás deste poderoso editor de texto e serve como um guia de referência para os comandos essenciais.

---

## 1. A Filosofia: Por que Neovim?

Neovim é um editor de texto **modal**. Em vez de usar o mouse e combinações complexas de teclas (como `Ctrl+Shift+S`), você usa "modos" para realizar diferentes tarefas. Isso mantém suas mãos no teclado e torna a edição de código incrivelmente eficiente.

- **Modo Normal:** O modo padrão. Usado para navegar pelo arquivo, deletar, copiar e colar texto.
- **Modo de Inserção:** Usado para escrever código.
- **Modo Visual:** Usado para selecionar texto.
- **Modo de Comando:** Usado para executar comandos como salvar, sair ou buscar.

A "linguagem" do Neovim é composta por **verbos** (ações) e **substantivos** (movimentos ou objetos de texto).

- `d` é o verbo "delete".
- `w` é o substantivo "word" (palavra).

Juntos, `dw` significa "delete word" (deletar palavra). Essa gramática é o que torna o Neovim tão poderoso.

---

## 2. Comandos Essenciais para Sobrevivência

Use estes comandos para começar a usar o Neovim imediatamente.

| Comando | Ação | Modo |
| :--- | :--- | :--- |
| `h`, `j`, `k`, `l` | Move o cursor (esquerda, baixo, cima, direita) | Normal |
| `i` | Entra no **Modo de Inserção** antes do cursor | Normal |
| `a` | Entra no **Modo de Inserção** depois do cursor | Normal |
| `<Esc>` | Retorna ao **Modo Normal** | Inserção/Visual |
| `:w` | Salva (**w**rite) o arquivo | Normal |
| `:q` | Sai (**q**uit) do editor | Normal |
| `:wq` | Salva e sai | Normal |
| `:q!` | Sai sem salvar (forçado) | Normal |
| `u` | Desfaz (**u**ndo) a última ação | Normal |
| `Ctrl+r` | Refaz (**r**edo) a ação desfeita | Normal |

---

## 3. Navegação e Edição no Dia a Dia

### Navegação Rápida
| Comando | Ação |
| :--- | :--- |
| `w` | Pula para o início da próxima palavra |
| `b` | Volta para o início da palavra anterior |
| `e` | Pula para o fim da palavra atual |
| `0` | Vai para o início absoluto da linha |
| `$` | Vai para o fim da linha |
| `gg` | Vai para a primeira linha do arquivo |
| `G` | Vai para a última linha do arquivo |

### Edição (Verbos)
| Comando | Ação | Exemplo de Uso |
| :--- | :--- | :--- |
| `d` | **d**elete | `dd` (deleta a linha inteira), `dw` (deleta a palavra) |
| `c` | **c**hange | `cw` (muda a palavra e entra no Modo de Inserção) |
| `y` | **y**ank (copiar) | `yy` (copia a linha inteira) |
| `p` | **p**aste (colar) | Cola o texto copiado depois do cursor |

### Busca
| Comando | Ação |
| :--- | :--- |
| `/texto` | Busca por "texto" para frente no arquivo |
| `?texto` | Busca por "texto" para trás |
| `n` | Pula para a próxima ocorrência da busca |
| `N` | Pula para a ocorrência anterior da busca |

---

## 4. A Gramática do Neovim: "Fale" com seu Editor

Combine verbos com objetos de texto para realizar edições complexas de forma simples.

- `i` significa "inner" (interno).
- `a` significa "around" (ao redor).

| Comando | Ação |
| :--- | :--- |
| `ci"` | **c**hange **i**nner **"** (muda o texto *dentro* das aspas) |
| `di(` | **d**elete **i**nner **(** (deleta o texto *dentro* dos parênteses) |
| `caw` | **c**hange **a**round **w**ord (muda a palavra e o espaço ao redor dela) |
| `dat` | **d**elete **a**round **t**ag (deleta o conteúdo ao redor de uma tag HTML) |

O comando `.` (ponto) é um dos mais poderosos: ele **repete a última alteração**. Se você usou `ci"` para mudar o texto em uma string, pode ir para outra e apenas pressionar `.` para fazer a mesma alteração.

---

## 5. Configuração Inicial: `init.lua`

Neovim é configurado usando a linguagem Lua no arquivo `init.lua`. Este arquivo deve estar em `~/.config/nvim/init.lua`.

A seguir, um exemplo de `init.lua` com configurações essenciais e bem comentadas, explicando o "porquê" de cada uma.

```lua
-- ~/.config/nvim/init.lua

-- Define o líder (leader), a tecla principal para seus atalhos personalizados.
-- O padrão é a contrabarra, mas muitos usam a barra de espaço.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Configurações (Options)
local opt = vim.opt

-- [[ Aparência ]]
opt.number = true             -- Mostra o número das linhas
opt.relativenumber = true     -- Mostra números de linha relativos para fácil navegação (ex: 10j)
opt.cursorline = true         -- Destaca a linha onde o cursor está
opt.scrolloff = 8             -- Mantém 8 linhas de contexto acima/abaixo do cursor ao rolar

-- [[ Comportamento ]]
opt.encoding = 'utf-8'        -- Define o encoding para UTF-8
opt.filetype = 'on'           -- Detecta o tipo de arquivo para aplicar configurações específicas
opt.hidden = true             -- Permite trocar de buffer sem salvar
opt.backup = false            -- Desativa arquivos de backup
opt.writebackup = false       -- Desativa arquivos de backup na escrita
opt.swapfile = false          -- Desativa o irritante arquivo .swp

-- [[ Indentação ]]
opt.expandtab = true          -- Converte 'tabs' em espaços
opt.tabstop = 2               -- Um 'tab' equivale a 2 espaços
opt.shiftwidth = 2            -- Nível de indentação com 2 espaços
opt.softtabstop = 2           -- Número de espaços ao pressionar 'tab'
opt.autoindent = true         -- Indentação inteligente
opt.smartindent = true        -- Indentação ainda mais inteligente para algumas linguagens

-- [[ Busca ]]
opt.incsearch = true          -- Mostra resultados da busca enquanto você digita
opt.hlsearch = true           -- Destaca todos os resultados da busca
opt.ignorecase = true         -- Ignora maiúsculas/minúsculas na busca...
opt.smartcase = true          -- ...a não ser que você digite uma letra maiúscula

-- Pequeno truque para limpar o destaque da busca pressionando Enter
vim.api.nvim_set_keymap('n', '<CR>', ':nohlsearch<CR>', { noremap = true, silent = true })

print('init.lua carregado com sucesso!')
```

### Como Usar?
1.  Crie o diretório se ele não existir: `mkdir -p ~/.config/nvim`
2.  Abra o arquivo: `nvim ~/.config/nvim/init.lua`
3.  Copie o conteúdo acima, cole no Neovim e salve com `:wq`.
4.  Feche e abra o Neovim novamente para que as mudanças tenham efeito.

---

**Anterior:** [Comandos Essenciais do Linux](./02_linux_commands.md) | **Próximo:** [Instalação e Filosofia do Neovim](./04_neovim_installation_philosophy.md)