" Files
set nobackup
set nowritebackup

" Visual Effect
set cmdheight=1
set updatetime=300
set signcolumn=yes
set cursorline
set t_Co=256
set termguicolors

" Correct RGB escape codes for vim inside tmux
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  hi! Normal ctermbg=NONE guibg=NONE 
  hi! Normal ctermbg=NONE guibg=NONE 
endif

" Language
set langmenu=en_US
set fileencodings=utf-8,chinese,ucs-bom,cp936
set fileencoding=utf-8
set fencs=utf-8,gbk,ucs-bom,shift-jis,gb18030,cp936
set termencoding=utf-8

" Line number
set number
set relativenumber

" Search
set ignorecase
set smartcase
set incsearch

" Indent
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set backspace=indent,eol,start

" Mouse
set mouse=a

" Clipboard
set clipboard=unnamedplus

" Plugins
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vim-which-key'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" pip3 install --user pynvim
"Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': 'Leaderf'}
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'
"Plug 'mg979/vim-visual-multi'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'francoiscabrol/ranger.vim', {'on': 'Ranger'}
Plug 'rbgrouleff/bclose.vim'
" Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'shirk/vim-gas'
" Plug 'jceb/vim-orgmode'
" Plug 'aserebryakov/vim-todo-lists'
if exists('g:gonvim_running')
    Plug 'akiyosi/gonvim-fuzzy'
endif
call plug#end()

syntax enable
set background=dark
colorscheme gruvbox
" molokai janah seoul256 desert256v2 blackdust colorsbox-material

" Transparent
if has('termguicolors')
  hi! Normal ctermbg=NONE guibg=NONE 
endif


" Key Bindings

" Unmap some keybindings provided by plugin
silent! unmap <leader>cc
silent! unmap <leader>cn
silent! unmap <leader>c<space>
silent! unmap <leader>cm
silent! unmap <leader>ci
silent! unmap <leader>cs
silent! unmap <leader>cy
silent! unmap <leader>c$
silent! unmap <leader>cA
silent! unmap <leader>ca
silent! unmap <leader>cl
silent! unmap <leader>cu
silent! unmap <leader>cb

map <space> <leader>
set timeoutlen=300 ttimeoutlen=0
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
if filereadable(expand("~/.config/nvim/keybindings.vim"))
    " load keymap from file
    source ~/.config/nvim/keybindings.vim
endif
" Some key not work in which-key plugin
nnoremap <silent> <leader><space> :noh<CR>
map , <Plug>(easymotion-prefix)

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_theme='molokai'

" Add the window number in front of the mode
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

if exists ('g:airline_added_func_WindowNumber')
else
    silent! call airline#add_statusline_func('WindowNumber')
    silent! call airline#add_inactive_statusline_func('WindowNumber')
    let g:airline_added_func_WindowNumber = 1
endif


" Auto-pair
au filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'} " tell auto-pair not pair quote in vim file

" Coc
inoremap <silent><expr> <tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<tab>" :
            \ coc#refresh()
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : <\C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Coc snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowLineNumbers = 1

" NERDCommenter
let g:NERDSpaceDelims = 1

" Ranger
let g:ranger_map_keys = 0

" EasyMotion
let g:EasyMotion_smartcase = 1

" LeaderF
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}

" Vim-Codefmt
call glaive#Install()
Glaive codefmt plugin[mappings]

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

" Additional
let g:asmsyntax = 'nasm'
let g:guifont = "MesloLGS NF:13"

" Source for GUI Client
if exists('g:gonvim_running') || has('gui_vimr')
  if filereadable(expand("~/.config/nvim/ginit.vim"))
    source ~/.config/nvim/ginit.vim
  endif
endif

if exists('g:gonvim_running') && filereadable(expand("~/.config/nvim/ginit_gonvim.vim"))
  source ~/.config/nvim/ginit_gonvim.vim
endif

if has('gui_vimr') && filereadable(expand("~/.config/nvim/ginit_vimr.vim"))
  source ~/.config/nvim/ginit_vimr.vim 
endif
