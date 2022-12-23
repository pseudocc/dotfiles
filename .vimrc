scriptencoding utf-8

set expandtab
set shiftwidth=0
set tabstop=2
set softtabstop=8
set smarttab
set smartindent
set autoindent
set modeline
set cursorline
set number

set wildmode=longest,list,full
set wildmenu

filetype plugin on
filetype plugin indent on

" Mappings
inoremap <S-Tab> <C-V><Tab>

" <Esc>[1;5A => <A-Up>
" <Esc>[1;5B => <A-Down>
" <Esc>[1;5C => <A-Right>
" <Esc>[1;5D => <A-Left>
nnoremap <Esc>[1;5A :m .-2<CR>==
nnoremap <Esc>[1;5B :m .+1<CR>==
nnoremap <Esc>[1;5C xp
nnoremap <Esc>[1;5D xhP

inoremap <Esc>[1;5A <Esc>:m .-2<CR>==gi
inoremap <Esc>[1;5B <Esc>:m .+1<CR>==gi
inoremap <Esc>[1;5C <Esc>xpgi
inoremap <Esc>[1;5D <Esc>xhPgi

vnoremap <Esc>[1;5A :m '<-2<CR>gv=gv
vnoremap <Esc>[1;5B :m '>+1<CR>gv=gv

" Appearance
syntax on
autocmd ColorScheme * highlight Normal ctermbg=NONE
colorscheme onedark
highlight Comment ctermfg=109

set list listchars=tab:\\u21A6\ ,trail:·,extends:>,precedes:<
set fillchars=vert:\\u2502

" indentLine
let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_leadingSpaceChar="·"
let g:indentLine_char="·"

" ALE
highlight ALEWarning ctermbg=172
highlight ALEError ctermbg=052
let g:ale_sign_error="\u2297 "
let g:ale_sign_warning="\u26A0 "
let g:ale_fixers = {
  \ 'typescript': ['deno'],
  \ 'javascript': ['deno'],
  \ }
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)
set omnifunc=ale#completion#OmniFunc

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Strip trailing whitespace
function! StripWS()
  let cursor = getpos(".")
  let query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', cursor)
  call setreg('/', query)
endfunction
noremap <leader>ss :call StripWS()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" call ch_logfile(expand('/tmp/chlogfile.log'), 'w')
