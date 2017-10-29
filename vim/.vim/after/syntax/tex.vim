" Vim after/syntax file
" Language:	TeX

" Needed for split-up documents
syntax spell toplevel
"if s:tex_fast =~# 'r'
syn region texRefZone		matchgroup=texStatement start="\\\(page\|eq\)ref\*{"	end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\v\=ref\*{"		end="}\|%stopzone\>"	contains=@texRefGroup
"endif
