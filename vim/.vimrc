" We don't need no stinkin' compatibility.
set nocompatible

" Syntax/colour/highlighting
syntax enable
set background=dark
set hlsearch

" Overwrite SpellLocal highlighting to something unobtrusive.
hi SpellLocal term=underline ctermbg=8 gui=undercurl guisp=Black

set backspace=indent,eol,start  " backspace over everything in insert mode
set nojoinspaces                " autoformat: no double space after periods
set backup                      " keep a backup file
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set tildeop                     " Make ~ work as an operator
set splitbelow                  " Split below, as is sensible.
set splitright                  " Split right, as is sensible.

filetype plugin indent on       " Filetype plugins, ident rules

" -- DICTONARY SETTINGS ---

" Set standard dictionary, or dictionaries. Will be at end of final list, in
" order set here, unless they are in a parent directory to the current file,
" in which case they'll be in spellfile according to the algorithm.
"
" TODO: Sort out if this causes issues issues when unexpanded entries set
" here being are the same file as "discovered" spellfiles.
if has("spell")
  set spellfile=~/.vim/spellfile.add
endif

" The following is based on the work of one "Matt Wozniski-2", who responded
" to the vim mailing list with the code this is based off of, on the 6th of
" November, 2007, in a thread titled "a project-local spell file?"
"
" Obviously, many thanks to Matt.

au BufNewFile,BufRead * call SetupDictionary(expand("<afile>"))
function! SetupDictionary(file)
  " TODO: Make LANGS, PREFIXES be defined outside the function.
  " TODO: Consider dropping PREFIXES, and instead looking in the current dir
  " 	  for anything that matches the regex: "(\.?.+\.)?" . lang . "\.add"
  let LANGS = ["", "en", "en.utf-8"]
  let PREFIXES = ["", "spell", ".spell", "spellfile", ".spellfile"]

  " Get path to dir of given file, expanding out "~", "$HOME", and such.
  " ":h" modifier lops off the final path delimiter, so we need to add that
  " back.
  let file = fnamemodify(expand(a:file), ':p:h') . '/'

  " Split path on file delimiter, but keep it on the end of each entry (hence the 
  " use of \zs), then rejoin them "incrementally".
  " Ergo: "/my/foobar/path/"
  "    -> ["/", "my/", "foobar/", "path/"]
  "    -> ["/", "/my/", "/my/foobar/", "/my/foobar/path/"]
  let DIRS = split(file, '/\zs')
  for i in range(1, len(DIRS)-1)
    let DIRS[i] = DIRS[i-1] . DIRS[i]
  endfor

  " Go through DIRS, LANGS, and PREFIXES, finding spellfiles, removing them
  " from the local buffer's spellfile variable, and (re-)adding them to the
  " front.
  "
  " As DIRS is iterated through with the ultimate parent first and the
  " current directory last, this means that "parent" spellfiles will be moved
  " or added to the front _before_ spellfiles in subdirectories are. Hence,
  " subdirectory spellfiles have a higher "priority".
  "
  " The same goes for LANGS and PREFIXES - language codes and prefixes listed
  " later have higher priority in the final spellfile list.
  "
  " And yes. I know. Three nested loops. Cubic runtime. It's a hack, okay?
  " Okay...
  for dir in DIRS
    for lang in LANGS
      for prefix in PREFIXES

        " Builds the filename we're looking for.
        let potential = lang . ".add"
        if (prefix != "" && lang != "")
          " Only add delimiter if prefix and lang are both non-null.
          let potential = "." . potential
        endif
        let potential = prefix . potential

        if filereadable(dir . potential)
          exe "setlocal spellfile-=" . fnameescape(dir . potential)
          exe "setlocal spellfile^=" . fnameescape(dir . potential)
        endif
      endfor
    endfor
  endfor
endfunction

" --- MAPPINGS ---

" Tag-opening mappings, by Amjith:
" http://stackoverflow.com/a/563992
" CTRL + \ - Open tag in a new tab
noremap <C-\> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>

" F5       - Gundo mapping.
nnoremap <F5> :GundoToggle<CR>

" F10      - Remove trailing whitespace.
nnoremap <F10> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" CTRL-N   - Cycle number lines.
function! NumberToggle()
  if(&number == 0 && &relativenumber == 0)
    set number
  elseif(&relativenumber == 0)
    set relativenumber
  else
    set norelativenumber
    set nonumber
  endif
endfunction
nnoremap <C-n> :call NumberToggle()<cr>
