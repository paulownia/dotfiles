syn keyword cssColorProp contained accent-color
syn keyword cssColorProp contained color-scheme

syn keyword cssBackgroundProp contained backdrop-filter

syn match cssBoxProp contained "\<margin-\(inline\|block\)\(-\(start\|end\)\)\=\>"
syn match cssBoxProp contained "\<padding-\(inline\|block\)\(-\(start\|end\)\)\=\>"

syn match cssBorderProp contained "\<border-\(inline\|block\)\(-\(start\|end\)\)\=\(-\(color\|style\|width\)\)\=\>"

syn match cssDimensionProp contained "\<\(\(max\|min\)-\)\=\(inline\|block\)-size\>"

syn match cssPositioningProp contained "\<inset\(\(-\(inline\|block\)\)\(-\(start\|end\)\)\=\)\=\>"

syn match cssPseudoClassId contained "\<\(marker\|backdrop\)\>"

syn keyword cssPseudoClassId contained any-link

syn region cssPseudoClassFn contained matchgroup=cssFunctionName start="\<has(" end=")" contains=cssStringQ,cssStringQQ,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier
