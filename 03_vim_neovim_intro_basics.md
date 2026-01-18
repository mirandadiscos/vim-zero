# 03. Introdução e Comandos Essenciais (Vim e Neovim)

Este guia é o seu ponto de partida para o mundo da edição modal com Vim e Neovim. Ele explica a filosofia por trás desses poderosos editores de texto e serve como um guia rápido para os comandos mais comuns, permitindo que você comece a editar de forma eficiente.

## 1. Por que Usar o Vim/Neovim?

Em uma era dominada por IDEs visualmente ricos como VS Code, a ideia de usar um editor de texto baseado em terminal como o Vim ou o Neovim pode parecer um retrocesso. No entanto, esses editores modais não apenas sobrevivem, mas prosperam em nichos de desenvolvimento de alta performance por razões que vão muito além da nostalgia, oferecendo uma experiência de edição extremamente eficiente e personalizável.

### a) A Filosofia Central: Edição Modal
A característica mais distintiva do Vim é sua **edição modal**. Você escolhe a ferramenta certa (o modo) para o trabalho: Modo Normal para navegar e manipular, Modo de Inserção para escrever, e Modo Visual para selecionar. Essa abordagem otimiza as tarefas mais comuns (leitura e modificação), permitindo que você edite sem tirar as mãos da *home row*.

### b) A "Linguagem" do Vim: Eficiência e Composabilidade
O Vim transforma a edição de texto em uma linguagem com uma gramática simples: **`verbo + substantivo`**. Por exemplo, `diw` (delete inner word - deletar palavra interna) é uma "frase" que você fala para o editor. Essa gramática, combinada com o operador ponto (`.`) para repetir a última alteração, torna a edição incrivelmente eficiente.

### c) Ubiquidade e Leveza
O Vim (ou `vi`) está pré-instalado em praticamente todos os sistemas Unix. Ele inicia instantaneamente e consome uma fração mínima de recursos, tornando-o ideal para qualquer ambiente.

### d) Customização Infinita
Vim e Neovim são camaleões. Através de plugins e seus arquivos de configuração (`.vimrc` ou `init.lua`), você constrói o seu IDE perfeito, adaptado ao seu fluxo de trabalho.

### e) O Custo do Aprendizado vs. O Retorno do Investimento
A curva de aprendizado é íngreme, mas o potencial de crescimento em velocidade e eficiência é quase ilimitado. É um investimento em uma habilidade que se pagará ao longo de toda a sua carreira.

---

## 2. Os Conceitos Fundamentais

### a) A Origem: `vi` e Vim

*   **`vi`:** Criado por Bill Joy em 1976, um dos primeiros editores de tela cheia.
*   **Vim (Vi IMproved):** Criado por Bram Moolenaar em 1991, um clone vastamente melhorado do `vi` com desfazer, sintaxe colorida e sistema de plugins.

### b) Os "Motores" do Vim/Neovim: Os Modos de Edição

1.  **Modo Normal (Normal Mode):** O modo padrão. Use para navegar, deletar, copiar, colar e executar a maioria dos comandos. (Pressione `<Esc>` de qualquer outro modo).
2.  **Modo de Inserção (Insert Mode):** O modo para digitar texto. (Entre com `i`, `a`, `o`, `O`).
3.  **Modo Visual (Visual Mode):** O modo para selecionar texto antes de aplicar um comando. (Entre com `v`, `V`, `Ctrl+v`).
4.  **Modo de Comando (Command-Line Mode):** O modo para executar comandos complexos que começam com `:`. (Pressione `:` no Modo Normal).

### c) A Linguagem do Vim: Verbo + Substantivo (Detalhado)
*   **Operadores (Verbos):** `d` (delete), `c` (change), `y` (yank/copy), `v` (visual), `gU` (uppercase), `gu` (lowercase), `>` (indentar).
*   **Movimentos (Substantivos):** `h,j,k,l`, `w` (word), `b` (back), `e` (end), `ge`, `$` (end of line), `0` (start of line), `^` (first non-blank), `gg`, `G` (last line), `f{char}`, `t{char}`.
*   **Objetos de Texto (Substantivos):** O par `i` (inner) e `a` (around) é usado com delimitadores: `w` (word), `s` (sentence), `p` (paragraph), `(`, `)`, `{`, `}`, `[`, `]`, `<`, `>`, `'`, `"`, `` ` ``.

### d) A Configuração: `.vimrc` e `init.lua`

*   **Vim:** Usa `.vimrc` (Vimscript) em `~/.vimrc`.
*   **Neovim:** Prefere `init.lua` (Lua) em `~/.config/nvim/init.lua`, mas pode usar `init.vim` (Vimscript) e ser compatível com `.vimrc`.

---

## 3. Guia Rápido de Comandos (Cheat Sheet)

Este guia é uma referência rápida para os comandos mais comuns, organizados por nível de proficiência.

### a) Nível 1: Comandos de Sobrevivência
*Estes são os comandos essenciais para abrir um arquivo, fazer uma pequena alteração e sair sem destruir nada.*

*   **Salvar e Sair (Modo de Comando)**
    *   `:w` - **w**rite. Salva as alterações.
    *   `:q` - **q**uit. Fecha o editor. Falhará se houver alterações não salvas.
    *   `:wq` - Salva e fecha.
    *   `:q!` - Sai forçadamente, descartando alterações.
    *   `ZZ` - (No Modo Normal) Atalho rápido para `:wq`.
*   **Navegação e Edição Simples (Modo Normal)**
    *   `h`, `j`, `k`, `l` - Movimentação básica: esquerda, baixo, cima, direita.
    *   `x` - Deleta o caractere sob o cursor.
    *   `i` - **i**nsert. Entra no Modo de Inserção antes do cursor.
    *   `a` - **a**ppend. Entra no Modo de Inserção depois do cursor.
    *   `u` - **u**ndo. Desfaz a última alteração.
    *   `Ctrl+r` - **r**edo. Refaz uma alteração desfeita.
    *   `<Esc>` - Volta para o Modo Normal. A tecla mais importante.

### b) Nível 2: O Editor do Dia a Dia
*Comandos que transformam o editor em uma ferramenta de edição eficiente.*

*   **Navegação Rápida (Modo Normal)**
    *   `w` - Pula para o início da próxima **p**alavra.
    *   `b` - Volta para o início da palavra **a**nterior.
    *   `e` - Pula para o **f**im da palavra atual.
    *   `0` - Início absoluto da linha.
    *   `^` - Primeiro caractere não-branco da linha.
    *   `$` - Fim da linha.
    *   `gg` - Salta para a primeira linha do arquivo.
    *   `G` - Salta para a última linha do arquivo.
    *   `Ctrl+d` / `Ctrl+u` - Rola meia página para **b**aixo ou para **c**ima.
*   **Operadores (Verbos) Comuns (Modo Normal)**
    *   `d` - **d**elete. Precisa de um movimento. Ex: `dd` (deleta linha), `dw` (deleta palavra), `d$` (deleta até fim da linha).
    *   `c` - **c**hange. Similar ao `d`, mas entra no Modo de Inserção. Ex: `cc` (muda linha), `cw` (muda palavra).
    *   `y` - **y**ank (copiar). Ex: `yy` (copia linha), `yw` (copia palavra).
    *   `p` / `P` - **p**aste. Cola depois (`p`) ou antes (`P`).
*   **Busca (Modo Normal)**
    *   `/texto` - Busca por "texto" para frente.
    *   `?texto` - Busca por "texto" para trás.
    *   `n` / `N` - Pula para a **p**róxima ou anterior ocorrência.

### c) Nível 3: A Gramática do Vim/Neovim
*Aqui você deixa de pensar em atalhos e começa a falar a "linguagem" do editor, combinando verbos e substantivos.*

*   **O Ponto Mágico (`.`)** - Repete a última **alteração**.
*   **Objetos de Texto** (`i` - inner, `a` - around):
    *   `ci"` - Muda o texto **d**entro das **a**spas.
    *   `ci(` - Muda o texto **d**entro dos **p**arênteses.
    *   `diw` - Deleta a **p**alavra **i**nterna.
    *   `caw` - Muda **u**ma **p**alavra (incluindo espaço).
    *   `dat` - Deleta o conteúdo **a**o redor de uma **t**ag HTML.
*   **Janelas (Splits)**
    *   `:sp <arquivo>` - Abre em nova janela horizontal.
    *   `:vsp <arquivo>` - Abre em nova janela vertical.
    *   `Ctrl+w` + `h,j,k,l` - Navega entre janelas.
    *   `Ctrl+w` + `q` - Fecha a janela atual.

### d) Nível 4: Magia Negra do Vim/Neovim
*Comandos que fazem outros desenvolvedores perguntarem "como você fez isso?".*

*   **Macros (Gravando suas Ações)**
    *   `q<letra>` - Começa a gravar no registro `<letra>`.
    *   `q` - Para a gravação.
    *   `@<letra>` - Executa a macro.
    *   `@@` - Repete a última macro.
*   **Marcadores (Marks)**
    *   `m<letra>` - Cria um marcador.
    *   `` `<letra> `` - Salta para a posição exata.
    *   `'<letra>` - Salta para o início da linha.
*   **Registros (Áreas de Transferência Múltiplas)** - O editor tem múltiplos registros (a-z) para copiar e colar.
    *   `"<letra>y` - Copia para o registro `<letra>`.
    *   `"<letra>p` - Cola do registro `<letra>`.
*   **Outros Comandos Poderosos**
    *   `Ctrl+a` / `Ctrl+x` - Incrementa ou decrementa o primeiro número.
    *   `gf` - **g**oto **f**ile. Abre o arquivo sob o cursor.

---

## 4. Dicas e Configurações Essenciais para o Editor

O arquivo de configuração do seu editor (`.vimrc` para Vim ou `init.lua` para Neovim) é o coração da personalização.

### a) Exemplo de um `.vimrc` (Vimscript)

```vim
" =============================================================================
"  Configurações Gerais e de Comportamento
" =============================================================================

" Ativa a sintaxe de cores. Essencial para programação.
syntax on

" Habilita o suporte a plugins e detecção de tipo de arquivo.
filetype plugin indent on

" Define o encoding para UTF-8, o padrão moderno.
set encoding=utf-8

" Desativa a criação de arquivos de backup irritantes (.swp).
set nobackup
set nowritebackup
set noswapfile

" =============================================================================
"  Interface e Aparência (UI)
" =============================================================================

" Mostra o número das linhas na lateral.
set number

" Mostra o número relativo da linha a partir da posição do cursor.
" Facilita muito a navegação vertical (ex: 10j para pular 10 linhas para baixo).
set relativenumber

" Destaca a linha onde o cursor está.
set cursorline

" Mostra informações de estado (modo, arquivo) na parte inferior.
set showmode
set showcmd

" Mantém 8 linhas de contexto acima/abaixo do cursor ao rolar a página.
set scrolloff=8

" =============================================================================
"  Busca (Search)
" =============================================================================

" Conforme você digita a busca, o Vim já vai pulando para os resultados.
set incsearch

" Destaca todos os resultados de uma busca.
set hlsearch

" Ignora maiúsculas/minúsculas ao buscar...
set ignorecase
" ...a não ser que você digite alguma letra maiúscula na sua busca.
set smartcase

" =============================================================================
"  Indentação e Formatação de Código
" =============================================================================

" Converte 'tabs' em espaços. Essencial para consistência.
set expandtab

" Define que um 'tab' (e um nível de indentação) equivale a 2 espaços.
" (Use 4 se for a convenção do seu projeto/linguagem)
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Indentação inteligente baseada na linguagem do arquivo.
set autoindent
set smartindent

" =============================================================================
"  Dica Extra: Plugins
" =============================================================================

" O Vim moderno ganha superpoderes com plugins.
" Considere pesquisar sobre um gerenciador de plugins como o 'vim-plug'.
" Com ele, você pode instalar facilmente coisas como:
"
" - 'NERDTree': Uma árvore de arquivos lateral.
" - 'vim-airline': Uma barra de status bonita e informativa.
" - 'coc.nvim': Autocomplete inteligente (similar ao VS Code).
"
" A instalação de plugins geralmente envolve adicionar linhas como esta no .vimrc:
"
" call plug#begin()
"   Plug 'preservim/nerdtree'
"   Plug 'vim-airline/vim-airline'
" call plug#end()
"
" (Isso requer que o vim-plug já esteja instalado)

```

### b) Como usar?

1.  Abra um terminal.
2.  Crie ou edite o arquivo com o comando: `vim ~/.vimrc`
3.  Copie o conteúdo acima, cole no Vim e salve (`:wq`).
4.  Feche e abra o Vim novamente para ver as mudanças.

---

**Anterior:** [Guia de Comandos Linux para Desenvolvedores](./02_linux_commands.md) | **Próximo:** [Neovim: Instalação e Filosofia](./04_neovim_installation_philosophy.md)
```