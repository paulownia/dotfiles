" html5 tag
syn keyword cssTagName article aside section header footer canvas video audio nav

" property
syn match cssFontProp contained "\<border-\(\(top-right\|bottom-right\|bottom-left\|top-left\)-\)\=radius\>"
syn match cssFontProp contained "\<box-shadow\>"

" color
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(rgba\|hsla\=\)\s*(" end=")" oneline keepend

" pseudo class
syn keyword cssPseudoClassId empty root odd even 
syn match cssPseudoClassId contained "\(first\|last\|only\)-\(of-type\|child\)" 
syn region cssPseudoClassNth matchgroup=cssPseudoClassId start=":nth-\(last-\)\=\(child\|of-type\)(" end=")" oneline
syn region cssPseudoClassNot matchgroup=cssPseudoClassId start=":not(" end=")" oneline 

" patch
syn match cssColorProp contained "\<background-repeat\>"
