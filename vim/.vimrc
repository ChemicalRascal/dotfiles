" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Syntax/colour/highlighting
syntax enable
set background=dark
set hlsearch

" Overwrite SpellLocal highlighting to something unobtrusive.
hi SpellLocal term=underline ctermbg=8 gui=undercurl guisp=Black

" Call pathogen.
" What this does is tell pathogen to go to the default pathogen folder
" (~/.vim/bundle) and do it's pathogen miracle magic stuff.
call pathogen#infect()
" Now get pathogen to re-do the helptags, runtime path.
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set backup			" keep a backup file
set history=50			" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching

filetype plugin indent on	" Filetype plugins, ident rules

" Set custom dictionary.
if has("spell")
  set spellfile=~/.vim/spellfile.add
endif

" F8 - Gundo mapping.
nnoremap <F8> :GundoToggle<CR>

" F10 - Remove trailing whitespace.
nnoremap <F10> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" CTRL-N - Cycle number lines.
function! NumberToggle()
  if(&number == 0 && &relativenumber == 0)
    set number
  elseif(&relativenumber == 0)
    set relativenumber
  else
    set norelativenumber
    set nonumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
