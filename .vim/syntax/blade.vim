" Language:	    Blade (Laravel)
" Maintainer:	xsbeats <jwalton512@gmail.com>
" URL:	        http://github.com/xsbeats/vim-blade
" License:      WTFPL

if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet b:current_syntax

runtime! syntax/php.vim
unlet b:current_syntax

syn match bladeConditional /@\(choice\|each\|elseif\|empty\|extends\|append\|stack\|push\|for\|foreach\|forelse\|if\|include\|lang\|section\|unless\|while\|yield\)\>\s*/ nextgroup=bladeParenBlock containedin=ALLBUT,bladeComment

syn match bladeKeyword /@\(else\|endpush\|endfor\|endforeach\|endforelse\|endif\|endsection\|endunless\|endwhile\|overwrite\|parent\|show\|stop\)\>/ containedin=ALL,bladeComment

syn region bladeComments start=/\s*{{--/ end=/--}}/ contains=bladeComment keepend
syn match bladeComment /.*/ contained containedin=bladeComments

syn region bladeEchoUnescaped matchgroup=bladeEchoDelim start="\([@|{]\)\@<!{{\(--\)\@!" end="}}" contains=@phpClInside containedin=ALLBUT,bladeComment
syn region bladeEchoEscaped matchgroup=bladeEchoDelim start="\(@\)\@<!{{{" end="}}}" contains=@phpClInside containedin=ALLBUT,bladeComment
syn region bladeUnescapedEcho matchgroup=bladeEchoDelim start=/@\@<!\s*{!!/ end=/!!}\s*/ oneline contains=@phpClTop containedin=ALLBUT,bladeComment


syn cluster bladeStatement contains=bladeConditional,bladeKeyword

syn region bladeParenBlock start="(" end=")" contained oneline contains=bladeParenBlock,@phpClInside,@bladeStatement extend keepend

hi def link bladeComment Comment
hi def link bladeConditional Conditional
hi def link bladeKeyword Keyword
hi def link bladeEchoDelim Delimiter

let b:current_syntax = 'blade'
