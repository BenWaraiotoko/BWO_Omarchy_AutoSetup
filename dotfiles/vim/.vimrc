" ============================================================================
" Minimal Vim Configuration for Learning
" ============================================================================
" Zero-plugin config for learning Vim fundamentals.
" Run 'vimtutor' to get started.
" ============================================================================

set nocompatible
syntax on
filetype plugin indent on

" Display
set number
set relativenumber
set showcmd
set wildmenu
set showmatch
set laststatus=2
set ruler

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Scrolling
set scrolloff=8
set sidescrolloff=8

" Performance
set lazyredraw

" Files
set nobackup
set nowritebackup
set noswapfile
set hidden

" Clipboard — Linux (Wayland/X11)
set clipboard=unnamedplus

" Splits
set splitright
set splitbelow

" Visual
set visualbell
set noerrorbells

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" History
set history=1000
set undolevels=1000

" Leader
let mapleader = " "

" ─────────────────────────────────────────────────────────────
" Key mappings
" ─────────────────────────────────────────────────────────────
nnoremap <silent> <Esc> :noh<CR><Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vnoremap < <gv
vnoremap > >gv

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
