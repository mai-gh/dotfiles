"colorscheme darkblue

set nu
set mouse=r
syntax on

" set bash like tab completion
set wildmode=longest,list 

" go to the position I was when last editing the file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"set textwidth=80
set wrap
set linebreak

set title 
command P %!prettier --stdin-filepath foo.js
command Pjs %!prettier --stdin-filepath foo.js
command Pjson %!prettier --stdin-filepath foo.json
command Pcss %!prettier --stdin-filepath foo.json

map <F12> :Pjs<CR> 
command WQ wq
command Wq wq
command W w
command Q q
"hi MatchParen cterm=bold ctermbg=none ctermfg=yellow


set laststatus=2


"function! InsertStatuslineColor(mode)
"  "https://vi.stackexchange.com/questions/19247/how-to-get-the-current-mode-in-vim 
" if a:mode == 'i'
"    hi statusline ctermfg=1 ctermbg=15
"  elseif a:mode == 'n' 
"    hi statusline  ctermfg=0 ctermbg=8
"  else
""    hi statusline ctermfg=15 ctermbg=15
"  endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertEnter * hi statusline ctermfg=1 ctermbg=15
"au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
au InsertLeave * hi statusline ctermfg=17  ctermbg=8
set timeoutlen=0

" default the statusline to green when entering Vim
hi statusline ctermfg=17 ctermbg=8

" https://vi.stackexchange.com/questions/19661/change-set-color-to-a-string-in-statusline
"hi User2 ctermfg=red ctermbg=black
"hi User2 ctermfg=white ctermbg=8
hi User2 ctermfg=White ctermbg=0

"" Formats the statusline
"set statusline=%f                           " file name
"set statusline=%2*\ \ \ %F\ \ \ %*                           " file name
set statusline=%2*\ \ \ 
set statusline+=%F
"set statusline+=%f
set statusline+=\ \ \ %*                           " file name
set statusline+=%=                        " align left
set statusline+=%l:%c          " line X of Y [percent of file]
set statusline+=\ %y      "filetype
set statusline+=%h      "help file flag
"set statusline+=%o      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
" Puts in the current git status
"    if count(g:pathogen_disabled, 'Fugitive') < 1   
"        set statusline+=%{fugitive#statusline()}
"    endif

"set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
"set statusline+=\ C:\ %c                    " current column
set statusline+=\ %{strlen(&fenc)?&fenc:'none'}\ "file encoding
set statusline+=%{&ff}\ "file format
"set statusline+=\ Buf:%n                    " Buffer number
"set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
hi Comment ctermbg=234 ctermfg=8
