"""""" .vimrc 


"""" vim_plug

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'
Plug 'vim-skk/eskk.vim'
Plug 'fuenor/im_control.vim'
Plug 'itchyny/lightline.vim'
Plug 'vlime/vlime', {'rtp': 'vim/'}

call plug#end()


"""" plugin setting

"" ddc.vim
call ddc#custom#patch_global('sources', ['eskk'])
call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank']
    \ },
    \ 'eskk': {'mark': 'eskk', 'matchers': [], 'sorters': []},
    \ })

"" eskk.vim
let g:eskk#directory = $HOME . "/.config/eskk"
if empty(glob(g:eskk#directory . '/SKK-JISYO.L'))
  call mkdir(g:eskk#directory, 'p')
  call system('curl -o ' . g:eskk#directory . '/SKK-JISYO.L.gz "https://skk-dev.github.io/dict/SKK-JISYO.L.gz"')
  call system('gzip -d ' . g:eskk#directory . '/SKK-JISYO.L.gz')
endif
let g:eskk#dictionary = {'path': g:eskk#directory . "/my_jisyo", 'sorted': 0, 'encoding': 'utf-8',}
let g:eskk#large_dictionary = {'path': g:eskk#directory . "/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp',}
let g:eskk#kakutei_when_unique_candidate = 1 "漢字変換した時に候補が1つの場合、自動的に確定する
let g:eskk#enable_completion = 1             "neocompleteを入れないと、1にすると動作しなくなるため0推奨
let g:eskk#no_default_mappings = 0           "デフォルトのマッピングを削除
let g:eskk#keep_state = 0                    "ノーマルモードに戻るとeskkモードを初期値にする
let g:eskk#egg_like_newline = 1              "漢字変換を確定しても改行しない

"" im_control.vim
let IM_CtrlMode=6
inoremap <silent> <C-k> <C-^><C-r>=IMState('FixMode')<CR>

"" vlime.vim
nnoremap <silent> <LocalLeader>rr :call VlimeStart()<CR>

let g:vlime_cl_impl = "mondo"
let g:vlime_cl_use_terminal = v:true
let g:vlime_window_settings = {
    \ 'server': {'pos': 'botright', 'size': v:null, 'vertical': v:true}
    \ }

function! VlimeBuildServerCommandFor_mondo(vlime_loader, vlime_eval)
    return ["mondo", "--server", "vlime"]
endfunction

function! VlimeStart()
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))
endfunction


"""" key mapping
nnoremap j gj
nnoremap k gk
inoremap jk <esc>
nnoremap <space>b :w<CR>:make expand("%:r")<CR>
nnoremap <space>r :make run<CR>
nnoremap <space>c :cclose<CR>
nnoremap <space>w :w<CR>
nnoremap <space>q :q<CR>
nnoremap <space>x :wq<CR>
nnoremap <space>p :w<CR>:bp<CR>
nnoremap <space>n :w<CR>:bn<CR>
"autocmd InsertCharPre 


"""" general setting
syntax on
set t_Co=256
set backspace=start,eol,indent
set ambiwidth=double
set formatoptions+=mMj
set display+=lastline
set laststatus=2
set title
set number
set ruler
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set clipboard&
set clipboard^=unnnamedplus

" open Quickfix automatically
autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrep copen

" set filetype to lisp
autocmd BufNewFile,BufRead *.ros  set ft=lisp

"colorscheme molokai
highlight LineNr ctermfg=239
highlight LineNr ctermbg=234
hi clear CursorLine
highlight CursorLine ctermbg=233

" INSERT, NORMAL mode status line  color
"augroup InsertHook
	"autocmd!
	"autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
	"autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
"augroup END


