set scrolloff=10
set undofile
set undodir=~/.cache/nvim/undodir
set noshowmode
set signcolumn=number
set hidden
set autowriteall
set nowrap

set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set mouse=a                 " enable mouse click
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " relative line numbers instead of always absolute
set termguicolors           " terminal colors
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 80 column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

" Some LSP servers have issues with backup files
set nobackup
set nowritebackup


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'gruvbox-community/gruvbox'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'elixir-editors/vim-elixir'
Plug 'dense-analysis/ale'

Plug 'vim-test/vim-test'
Plug 'vim-airline/vim-airline'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

call plug#end()


colorscheme gruvbox

" move line or visually selected block - alt+j/k
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set completeopt=menu,menuone,noselect

let g:ale_fix_on_save = 1
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'elixir': ['mix_format']
            \}

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" :CocConfig<CR> and add "diagnostic.displayByAle": true
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

let g:coc_global_extensions = ['coc-json', 'coc-elixir']

" Needs apt install ripgrep
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nmap <silent> <leader>ts :TestNearest<CR>
nmap <silent> <leader>tt :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

nnoremap <C-n> :NERDTreeToggle<CR>

lua require("treesitter")
