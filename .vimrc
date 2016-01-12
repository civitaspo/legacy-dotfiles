set ignorecase                 " 検索時に大文字小文字を区別しない
set smartcase                  " 検索語に大文字を混ぜると検索時に大文字を区別する
set hlsearch                   " 検索語にマッチした単語をハイライトする
                               " 逆は [ set nohlsearch ]
set encoding=utf-8
set nonumber                   " 行番号を非表示
set showmatch                  " 括弧入力時に対応する括弧を強調する
syntax on                      " 構文ごとに色分け表示する
set wrap                       " ウィンドウ幅で行を折り返す
set autoindent                 " 新しい行のインデントを現在行と同じにする
"set smartindent                " 新しい行を作ったときに高度な自動インデントを行う
set smarttab                   " 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set nobackup                   " バックアップファイルを作るディレクトリset backupdir=$HOME/vimbackup
set nowrapscan                 " 検索をファイルの先頭へループしない
set autoread                   " 他で書き換えられたら自動で読み直す
set hidden                     " 編集中でも他のファイルを開けるようにする
set showcmd                    " コマンドをステータス行に表示
set showmode                   " 現在のモードを表示
set backspace=start,eol,indent " 普通のエディタみたいに操作
set ruler                       "カーソルが何行目の何列目に置かれているかを表示する

au BufNewFile,BufRead *.sql    set tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.js     set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.json   set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.coffee set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.scss   set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead Gemfile  set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.watchr set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rb     set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rake   set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.yaml   set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.yml    set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.erb    set tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.pl     set tabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.pm     set tabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.t      set tabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.psgi   set tabstop=4 shiftwidth=4 expandtab
au BufNewFile,BufRead *.sh     set tabstop=2 shiftwidth=2 expandtab


"-------------------------------------------------------------------------------
"" UI関連 Colors
"-------------------------------------------------------------------------------

" ターミナルタイプによるカラー設定
 if &term =~ "xterm-256color" || "screen-256color"
    " 256色
     set t_Co=256
     set t_Sf=[3%dm
     set t_Sb=[4%dm
 elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
     set t_Co=16
     set t_Sf=[3%dm 
     set t_Sb=[4%dm
 endif

" カレントウィンドウにのみ罫線を引く
set cursorline
highlight CursorLine cterm=underline ctermbg=235

set cursorcolumn
highlight CursorColumn ctermbg=235

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast
" with neobundle
colorscheme hybrid

"-------------------------------------------------------------------------------
"" NeoBundle
"-------------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"

if has('vim_starting')
   set nocompatible               " Be iMproved
   set runtimepath+=~/.config/vim/plugins/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" call neobundle#end()
" Recommended to install
" After install, turn shell ~/.config/vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" My Bundles here:
"
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell.vim'
nnoremap shell :VimShell<CR>
nnoremap pry :VimShellInteractive pry<CR>

NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#skip_auto_completion_time = '0.8'

NeoBundle 'Shougo/unite-outline'
let g:unite_split_rule = 'botright'
noremap <C-\> :<C-u>Unite -vertical -winwidth=40 outline<CR>

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
let s:default_snippet = neobundle#get_neobundle_dir() . '/neosnippet-snippets/neosnippets' " 本体に入っているsnippet
let s:my_snippet = "$HOME/.config/vim/snippets" " 自分のsnippet
let g:neosnippet#snippets_directory = s:my_snippet
let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet
imap <silent><C-S> <Plug>(neosnippet_expand_or_jump)
inoremap <silent><C-U> <ESC>:<C-U>Unite neosnippet<CR>
nnoremap <silent><Space>e :<C-U>NeoSnippetEdit -split<CR>
smap <silent><C-S> <Plug>(neosnippet_expand_or_jump)

NeoBundle 'osyo-manga/vim-over'
nnoremap <silent> <C-S> :OverCommandLine<CR>%s/

NeoBundle 'w0ng/vim-hybrid'

NeoBundle 'sudo.vim'

" ref: http://threetreeslight.com/post/56296194503/fugitive-vim
NeoBundle 'tpope/vim-fugitive'
nnoremap <C-G>   <Nop>
" 新しい窓を作ってgit statusを表示
nnoremap <C-G>st :Gstatus<CR>
" 現在のソースの変更点をvimdiffで表示
nnoremap <C-G>d  :Gdiff<CR>
" 現在開いているソースをgit add
nnoremap <C-G>w  :Gwrite<CR>
" 現在開いているソースの直前のコミット時のソースを表示
nnoremap <C-G>r  :Gread<CR>
" 現在のソースをgit blame。vimが色づけしてくれる
nnoremap <C-G>br :Gblame<CR>

NeoBundle 'tpope/vim-endwise' " Ruby向けにendを自動挿入してくれる

NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<C-E>'
let g:user_emmet_settings = {
      \   'lang' : 'ja'
      \ }
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'kchmck/vim-coffee-script'

call neobundle#end()

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

"-------------------------------------------------------------------------------
"" Search
"-------------------------------------------------------------------------------
nnoremap <silent> /
      \ :<C-u>Unite -buffer-name=search -auto-highlight -start-insert line:all<CR>

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
nnoremap <silent> \
      \ :<C-u>VimFilerExplore -split -winwidth=30 -no-quit<Cr> 
autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
  nnoremap <silent> <buffer>\ :q<Cr>
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }                     
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)


"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType unite nnoremap <silent> <buffer> <C-\> :q<CR>
au FileType unite inoremap <silent> <buffer> <C-\> <ESC>:q<CR>
au FileType vimfiler nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType vimfiler inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

""""""""""""""""""""""""""""
" markdownで書かれた文字列ハイライト
""""""""""""""""""""""""""""
let g:markdown_fenced_languages = [
\  'coffee',
\  'css',
\  'erb=eruby',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'sass',
\  'xml',
\]

""""""""""""""""""""""""""""
" key bindings
""""""""""""""""""""""""""""
noremap <C-c> :q<CR>
noremap <C-x> :wq<CR>
" noremap <C-w> :w<CR>
nnoremap w <Nop>
nnoremap <C-w><Down> <C-w>j
nnoremap <C-w><Up>   <C-w>k
nnoremap <C-w><Left> <C-w>h
nnoremap <C-w><Right> <C-w>l
nnoremap w<Down>  <C-w>j
nnoremap w<Up>    <C-w>k
nnoremap w<Left>  <C-w>h
nnoremap w<Right> <C-w>l
nnoremap ww       <C-w>w
nnoremap <C-f> <Right>
inoremap <C-f> <Right> 
nnoremap <C-b> <Left>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
