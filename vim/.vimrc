" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Call pathogen.
" What this does is tell pathogen to go to the default pathogen folder
" (~/.vim/bundle) and do it's pathogen miracle magic stuff.
call pathogen#infect()
" Now get pathogen to re-do the helptags, runtime path.
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Do the colour stuff.
syntax enable
set background=dark
" Overwrite default spelling stuff.
hi SpellLocal term=underline ctermbg=8 gui=undercurl guisp=Black

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Enable file type {detection, {plugins, indentation} rules}
filetype plugin indent on

" Set custom dictionary.
if has("spell")
  set spellfile=~/.vim/spellfile.add
endif

" Gundo.
nnoremap <F8> :GundoToggle<CR>

" CTRL-N (relative) number line function - cycle between abs, rel, and none.
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

" Remove trailing whitespace binding.
nnoremap <F10> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
