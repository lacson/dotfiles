execute pathogen#infect()
syntax on
filetype plugin indent on

" line numbers
set number

" lightline stuff
set laststatus=2
set noshowmode

" soft tabs
set tabstop=8
set shiftwidth=4
set softtabstop=0 expandtab smarttab

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <C-n> :NERDTreeToggle<CR>
