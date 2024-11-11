" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'wellle/context.vim'
Plug 'morhetz/gruvbox'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'tmhedberg/simpylfold'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'ap/vim-buftabline'
Plug 'airblade/vim-gitgutter'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jmcantrell/vim-virtualenv'
"Plug 'valloric/youcompleteme'
Plug 'justinmk/vim-sneak'
Plug 'yggdroot/indentline'
Plug 'tpope/vim-surround'
"Plug 'scrooloose/syntastic'
Plug 'ntpeters/vim-better-whitespace'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indentpython.vim'
Plug 'lepture/vim-jinja'
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
call plug#end()

filetype plugin indent on
syntax on

if need_to_install_plugins == 1
    echo "Installing plugins..."
   silent! PlugInstall
    echo "Done!"
    q
endif


" set splits
set splitbelow
set splitright

" always show the status bar
set laststatus=2

" enable 256 colors
set t_Co=256
set t_ut=

" turn on line numbering
set number

" sane text files
set fileformat=unix
set encoding=UTF-8
set fileencoding=utf-8
set colorcolumn=80
set viminfo='25,\"50,n~/.viminfo

" python editing
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set softtabstop=4 |
    \ set expandtab |
    \ set autoindent |

" fullstack editing
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

" emmet-vim
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
    \ 'javascript.jsx' : {
      \    'extends' : 'jsx',
      \  },
    \}

" word movement
imap <S-Left> <Esc>bi
map <S-Left> v<S-->
imap <S-Right> <Esc><Right>wi
map <S-Right> v<S-4>

" window pane movement
nmap <leader>w <C-w>

" indent/unindent with tab/shift-tab
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<

" mouse
set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction

" color scheme
syntax on
colorscheme onedark
" ayu settings
set termguicolors
"let ayucolor="mirage"
"colorscheme ayu
set cursorline
hi CursorLine term=bold cterm=bold guibg=darkmagenta
filetype on
filetype plugin indent on

" lightline
set noshowmode
let g:lightline = { 'colorscheme': 'onedark' }
" let g:lightline = { 'colorscheme': 'ayu' }

" code folding
set foldmethod=indent
set foldlevel=99
" enable folding w/ spacebar
nnoremap <space> za
" preview folded docstrings
let g:SimpylFold_docstring_preview=1

" wrap toggle
setlocal nowrap
noremap <silent> <leader>r :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Down>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction


" move through split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bd<CR>

" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" file browser
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <leader>n :call NERDTreeToggle()<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

function! StartUp()
    if 0 == argc()
         NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

"nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowClean = 1

" git-gutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '✹'
let g:gitgutter_sign_removed = '➖'
let g:gitgutter_sign_removed_first_line = '➖'
let g:gitgutter_sign_modified_removed = '➖'

" youcompleteme
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"map <leader>s :SyntasticCheck<CR>
"map <leader>d :SyntasticReset<CR>
"map <leader>e :lnext<CR>
"map <leader>r :lprev<CR>

" tag list
map <leader>t :TagbarToggle<CR>

" copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

" Disable auto-rendering of some markdown syntax
let g:markdown_syntax_conceal = 0

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
inoremap jk <ESC>

