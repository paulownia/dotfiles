" see /opt/homebrew/Cellar/neovim/x.x.x/share/nvim/runtime/syntax/css.vim
"
syn keyword cssColorProp contained accent-color
syn keyword cssColorProp contained color-scheme

syn keyword cssBackgroundProp contained backdrop-filter

syn match cssBoxProp contained "\<margin-\(inline\|block\)\(-\(start\|end\)\)\=\>"
syn match cssBoxProp contained "\<padding-\(inline\|block\)\(-\(start\|end\)\)\=\>"
syn keyword cssBoxProp contained overflow-anchor
syn keyword cssBoxProp contained overflow-clip-margin

syn match cssFlexibleBoxProp contained "\<place-\(items\|content\|self\)\>"

syn match cssBorderProp contained "\<border-\(inline\|block\)\(-\(start\|end\)\)\=\(-\(color\|style\|width\)\)\=\>"

syn match cssDimensionProp contained "\<\(\(max\|min\)-\)\=\(inline\|block\)-size\>"

syn match cssPositioningProp contained "\<inset\(\(-\(inline\|block\)\)\(-\(start\|end\)\)\=\)\=\>"

syn match cssPseudoClassId contained "\<\(marker\|backdrop\|modal\)\>"

syn keyword cssUIProp contained scroll-behavior
syn keyword cssUIProp contained overscroll-behavior
syn match cssUIProp contained "\<scroll-snap-\(type\|align\|stop\)\>"
syn match cssUIProp contained "\<overscroll-behavior-\(x\|y\|block\|inline\)\>"

syn keyword cssPseudoClassId contained any-link

syn region cssPseudoClassFn contained matchgroup=cssFunctionName start="\<has(" end=")" contains=cssStringQ,cssStringQQ,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier

syn match cssBackgroundProp contained "\<background-position-\(x\|y\)\>"

" css text module level 4
syn match cssTextProp contained "\<text-\|\(autospace\|spacing-trim\)\>"
syn keyword cssTextAttr contained no-autospace auto-phrase trim-auto


