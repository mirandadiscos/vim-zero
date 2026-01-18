" Este é um exemplo de arquivo .vimrc completo e pronto para uso.
" Para usar, copie este conteúdo para ~/.vimrc

" --- Configurações Básicas ---
set nocompatible            " Desabilita o modo compatível com vi (obrigatório para muitos plugins)
syntax on                   " Ativa o destaque de sintaxe
filetype plugin indent on   " Ativa detecção de tipo de arquivo, plugins e indentação inteligente

" --- Aparência ---
set number                  " Mostra números de linha
" set relativenumber        " Mostra números de linha relativos (útil para navegação)
set tabstop=4               " Número de espaços que um tab ocupa
set shiftwidth=4            " Número de espaços para auto-indentação
set expandtab               " Converte tabs em espaços
set autoindent              " Ativa auto-indentação
set smartindent             " Ativa smart-indentação (melhor para linguagens de programação)
set wrap                    " Quebra linhas longas
set showmatch               " Destaca parênteses correspondentes
set incsearch               " Realça resultados de busca enquanto digita
set hlsearch                " Realça todos os resultados de busca
set ignorecase              " Ignora maiúsculas/minúsculas em buscas
set smartcase               " Não ignora maiúsculas/minúsculas se houver letras maiúsculas na busca
set mouse=a                 " Ativa o suporte ao mouse em todos os modos (útil em terminais)
set cursorline              " Realça a linha atual do cursor
set textwidth=0             " Desabilita quebra de linha automática
set formatoptions-=t        " Impede quebra de linha automática

" --- Navegação e Edição ---
set scrolloff=8             " Mantém 8 linhas acima e abaixo do cursor ao rolar
set showcmd                 " Mostra o comando atual no canto inferior direito
set wildmenu                " Habilita menu de completação estilo bash
set wildmode=longest,list   " Completar no wildmenu

" --- Backup e Undo ---
set backup                  " Cria um arquivo de backup
set backupdir=~/.vim/backup " Onde armazenar os backups
set undodir=~/.vim/undo     " Onde armazenar o histórico de undo
set undofile                " Salva o histórico de undo após fechar o arquivo

" --- Mapeamentos (Exemplos) ---
" Mapeamento para salvar rapidamente
" noremap <C-s> :w<CR>

" Mapeamento para alternar entre buffers
" noremap <C-h> :bprevious<CR>
" noremap <C-l> :bnext<CR>

" --- Configurações para Plugins (Exemplo com Plug) ---
" Se você usar um gerenciador de plugins como vim-plug, a configuração seria assim:
" call plug#begin('~/.vim/plugged')
"
" Plug 'tpope/vim-fugitive'    " Gerenciamento de Git dentro do Vim
" Plug 'airblade/vim-gitgutter' " Indicadores de Git na barra lateral
" Plug 'vim-airline/vim-airline' " Barra de status customizável
"
" call plug#end()
"
" Para instalar plugins, execute :PlugInstall dentro do Vim.
