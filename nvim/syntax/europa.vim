" Vim syntax file
" Language: Europa
" Maintainer: Geoff Cadien
" Latest Revision: 05 January 2024

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword europaLangKeywords record end defm do
syn keyword europaBoolean true false

syn match europaOperator ":="

let b:current_syntax = "europa"
hi def link europaLangKeywords Keyword
hi def link europaBoolean Boolean
hi def link europaOperator Operator
