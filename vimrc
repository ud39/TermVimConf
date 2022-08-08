
set timeoutlen=1000
set ttimeoutlen=0

"Use new regular expression engine
set re=0


call plug#begin()

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" HTML, CSS, JS 
Plug 'tpope/vim-surround'

" VimWiki
Plug 'vimwiki/vimwiki', {'on': []}
command! VimWiki call plug#load('vimwiki')


call plug#end()

" Config for CoC
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Config FZF
nmap <C-P> :Files <CR>
imap <C-f> <plug>(fzf-complete-line)

"Format: Python vim PEP8
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ | set softtabstop=4
    \ | set shiftwidth=4
    \ | set textwidth=79
    \ | set fileformat=unix


"Format: JS HTML CSS, TS, C
au BufNewFile,BufRead *.ts,*.js,*.html,*.css,*.c
    \ set tabstop=2
    \ | set softtabstop=2
    \ | set shiftwidth=2

set number
set encoding=utf-8
set spelllang=en_us
set nospell
set foldenable
set foldlevelstart=10


" Coc highlights

highlight CocErrorFloat ctermfg=white 

"--------------------------------------------------------------------------------"
" Vim config
nnoremap ü <C-]>
nnoremap Ü <C-O>
nnoremap ä `
imap <C-c> <Esc>

let mapleader = " "
nnoremap <Leader>e :e!<CR>

set background=dark
set tags=./tags;/


" Autocmd
augroup COCPython
	autocmd!
	autocmd FileType python let b:coc_root_patterns = ['.git', '.venv', '.env']
	autocmd FileType python  nnoremap <buffer><silent><Leader>r :w!<CR>:!clear;python3 %<CR>
augroup END

" Turn hybrid line numbers on
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Tmux pane naming 
augroup Tmux
	autocmd!
	autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
	autocmd VimLeave * call system("tmux rename-window zsh")
	autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
augroup END
set title

" Command
command CreatePDF hardcopy > %.ps | !ps2pdf %.ps && rm %.ps

"--------------------------------------------------------------------------------"

" Cursor
" Remove underline color of number by
:hi LineNr term=bold cterm=None ctermfg=DarkGrey ctermbg=None gui=None guifg=DarkGrey guibg=None
:hi CursorLineNr cterm=bold term=bold ctermfg=yellow gui=bold

:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <silent><Leader>c :set cursorline! cursorcolumn!<CR>

"Mode Settings

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

autocmd VimEnter * stopinsert

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" HardMode disable arrow keys
" Remove newbie crutches in Command Mode
 cnoremap <Down> <Nop>
 cnoremap <Left> <Nop>
 cnoremap <Right> <Nop>
 cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
 inoremap <Down> <Nop>
 inoremap <Left> <Nop>
 inoremap <Right> <Nop>
 inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
 nnoremap <Down> <Nop>
 nnoremap <Left> <Nop>
 nnoremap <Right> <Nop>
 nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
 vnoremap <Down> <Nop>
 vnoremap <Left> <Nop>
 vnoremap <Right> <Nop>
 vnoremap <Up> <Nop>


" Statusline
let gitBranch=system("git rev-parse --abbrev-ref HEAD")
set laststatus=2
set statusline=\ 
execute "set statusline +=" . gitBranch
set statusline+=\ 
set statusline+=\|
set statusline+=\ %f 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c


" Now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif



" VimWiki
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.path_html = '~/vimwiki_html/'

let wiki_2 = {}
let wiki_2.path = '~/private/'
let wiki_2.path_html = '~/private_html/'

let g:vimwiki_list = [wiki_1, wiki_2]
