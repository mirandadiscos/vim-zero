# Guia de Plugins para Vim

Plugins são a maneira como transformamos o Vim de um simples editor de texto em uma ferramenta de desenvolvimento poderosa e personalizada. Este guia explica como usar um gerenciador de plugins para instalar e configurar funcionalidades adicionais.

## 1. Gerenciadores de Plugins

Um gerenciador de plugins automatiza a instalação, atualização e remoção de plugins. Embora existam várias opções como `Vundle` e `Pathogen`, nós usaremos o **`vim-plug`**, que é amplamente recomendado por sua velocidade (realiza instalações em paralelo) e facilidade de uso.

### Instalando o `vim-plug`
Este é um passo único. O comando abaixo baixa o arquivo `plug.vim` e o coloca no diretório `autoload`, que é onde o Vim o procura.

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## 2. Estrutura do `.vimrc` com `vim-plug`

Seu arquivo `.vimrc` é o coração da configuração do Vim. Para usar o `vim-plug`, você precisa adicionar a seguinte estrutura a ele:

```vim
" Inicia a seção de plugins. O vim-plug irá instalar os plugins neste diretório.
call plug#begin('~/.vim/plugged')

" ===============================================================
" A lista de plugins vai aqui.
" O formato é Plug 'desenvolvedor/nome-do-repositorio'
" ===============================================================

" Exemplo:
Plug 'tpope/vim-fugitive'


" ===============================================================
" Finaliza a seção de plugins e carrega os plugins instalados.
" ===============================================================
call plug#end()
```

### Comandos do `vim-plug`
Depois de adicionar um novo plugin à sua lista no `.vimrc`:
1.  Salve o arquivo e reinicie o Vim, ou recarregue o arquivo com `:so ~/.vimrc`.
2.  Execute `:PlugInstall` para que o `vim-plug` baixe e instale os novos plugins.
3.  Para remover plugins, delete a linha `Plug '...'` do seu `.vimrc` e execute `:PlugClean`.
4.  Para atualizar todos os plugins, execute `:PlugUpdate`.

---

## 3. Plugins Essenciais para Começar

Aqui está uma lista de plugins fundamentais que adicionam funcionalidades básicas de um IDE moderno.

*   **[NERDTree](https://github.com/preservim/nerdtree):** Um explorador de arquivos em árvore.
    *   **Por que usar?** Permite navegar pela estrutura do seu projeto sem sair do Vim, abrindo e gerenciando arquivos em uma barra lateral, similar a um IDE.
    *   **Instalação:** `Plug 'preservim/nerdtree'`

*   **[vim-airline](https://github.com/vim-airline/vim-airline):** Uma linha de status ("statusline") bonita e funcional.
    *   **Por que usar?** A statusline padrão do Vim é mínima. Airline mostra informações cruciais em tempo real: o modo atual, o branch do Git, o nome do arquivo, a porcentagem do arquivo e erros de linting.
    *   **Instalação:** `Plug 'vim-airline/vim-airline'`

*   **[fzf.vim](https://github.com/junegunn/fzf.vim):** Integração com o `fzf` para busca "fuzzy" de arquivos.
    *   **Por que usar?** A maneira mais rápida de abrir um arquivo. Em vez de navegar pela árvore de arquivos, você digita algumas letras do nome do arquivo e o `fzf` o encontra instantaneamente.
    *   **Instalação:** `Plug 'junegunn/fzf.vim'`
    *   **Dependência:** Requer que o `fzf` esteja instalado no seu sistema (veja `fzf_installation.md`).

*   **[ale](https://github.com/dense-analysis/ale):** (Asynchronous Linting Engine) Um motor de linting assíncrono.
    *   **Por que usar?** Analisa seu código enquanto você digita e mostra erros e avisos em tempo real, sem travar o editor. Essencial para capturar bugs cedo.
    *   **Instalação:** `Plug 'dense-analysis/ale'`

*   **[vim-commentary](https://github.com/tpope/vim-commentary):** Comandos para comentar e descomentar código.
    *   **Por que usar?** Comentar código no Vim pode ser tedioso. Este plugin oferece o atalho `gcc` para comentar uma linha e `gc` no modo visual para comentar um bloco, economizando muito tempo.
    *   **Instalação:** `Plug 'tpope/vim-commentary'`

*   **[vim-surround](https://github.com/tpope/vim-surround):** Manipulação de "arredores" (parênteses, aspas, tags).
    *   **Por que usar?** Permite adicionar, remover e trocar delimitadores com facilidade. Por exemplo, `cs"'` muda aspas duplas para simples ao redor de um texto. `ysiw(` envolve a palavra atual com parênteses.
    *   **Instalação:** `Plug 'tpope/vim-surround'`

---

## 4. Configurando Seus Plugins

A maioria dos plugins funciona "fora da caixa", mas o verdadeiro poder vem da customização. Você faz isso no seu `.vimrc`, geralmente *depois* da chamada `call plug#end()`.

### a) Com Variáveis Globais (`let g:...`)
Muitos plugins permitem que você altere seu comportamento através de variáveis globais. A documentação do plugin sempre informa quais variáveis estão disponíveis.

**Exemplo:** Por padrão, o NERDTree não mostra arquivos ocultos (como `.gitignore`). Para mudar isso:
```vim
" Deixe esta linha em algum lugar no seu .vimrc
let g:NERDTreeShowHidden = 1
```

### b) Com Mapeamento de Teclas (`map`)
Você pode criar atalhos para os comandos de um plugin. A forma mais segura de fazer isso é com `nnoremap`.

*   `nnoremap`: **n**ormal **no**n-**re**cursive **map**. Cria um atalho que só funciona no Modo Normal (`n`) e não é recursivo (não chama outros atalhos, evitando conflitos).

**Exemplo:** Em vez de digitar `:NERDTreeToggle` toda vez para abrir e fechar o NERDTree, vamos mapear para `Ctrl+n`:
```vim
" Mapeia Ctrl+n para alternar o NERDTree
" nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" <silent>: não mostra o comando na linha de comando.
" <C-n>: representa Ctrl+n.
" <CR>: "Carriage Return", simula pressionar Enter.
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
```

---

**Anterior:** [Guia de Comandos do Vim](./vim_cheatsheet.md) | **Próximo:** [Guia de Instalação e Otimização do `fzf`](./fzf_installation.md)

Sempre leia a documentação (`:help <nome-do-plugin>`) para descobrir as melhores maneiras de configurar um plugin para o seu fluxo de trabalho.