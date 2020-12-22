" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" map ctrl n to line numbers
:nmap <C-N><C-N> :set invnumber<CR>
"
" " Mouse and backspace set mouse=a " on OSX press ALT and click set bs=2 " make backspace behave like normal again " " " Rebind <Leader> key
" " I like to have it here becuase it is easier to reach than the default and
" " it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","
"
" " Bind nohl
" " Removes highlight of your last search
" " ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>
"
" " Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
"
"Quick quit command
noremap <Leader>e :quit<CR> "Quit current window
noremap <Leader>E :qa!<CR> "Quit all windows
"
" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

"map sort function to a key
vnoremap <Leader>s :sort<CR>

"better indentation
vnoremap < <gv 
vnoremap > >gv 
vnoremap <silent> # :s#^#\##<cr>:noh<cr>
vnoremap <silent> -# :s#^\###<cr>:noh<cr>

" FOR POWERLINE
set rtp+=/home/jade/.local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set showtabline=1
set noshowmode
set t_Co=256


" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

" FOR PATHOGEN.VIM
execute pathogen#infect()
syntax on
filetype plugin indent on

" For automatic line numbering
set number " show line numbers
set tw=79  " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t  " don't automatically wrap text when typing
" uncomment to have colum appear
"set colorcolumn=80

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Userful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Uncomment to have nerdtree automatically load nerdtree

"autocmd vimenter * NERDTree
"Nerd tree loads on the right
let g:NERDTreeWinPos = "right"

" toggle nerdtree
map <Leader>t :NERDTreeToggle<CR>

colorscheme atom

" for transparency
hi Normal guibg=NONE ctermbg=NONE

" for latex-live-preview
let g:livepreview_previewr = 'evince'

" Non regex method of finding duplicates
" reference: https://stackoverflow.com/questions/1268032/how-can-i-mark-highlight-duplicate-lines-in-vi-editor
function! HighlightRepeats() range
    let lineCounts = {}
    let lineNum = a:firstline
    while lineNum < a:lastline
        let lineText = getline(lineNum)
        if lineText != ""
            let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
        endif
        let lineNum = lineNum + 1
    endwhile
    exe 'syn clear Repeat'
    for lineText in keys(lineCounts)
        if lineCounts[lineText] >= 2
            exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
        endif
    endfor
endfunction
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
