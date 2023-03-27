syn keyword cssColorProp contained accent-color

syn match cssBoxProp contained "\<margin-\(inline\|block\)\(-\(start\|end\)\)\=\>"
syn match cssBoxProp contained "\<padding-\(inline\|block\)\(-\(start\|end\)\)\=\>"

syn match cssBorderProp contained "\<border-\(inline\|block\)\(-\(start\|end\)\)\=\(-\(color\|style\|width\)\)\=\>"

syn match cssDimensionProp contained "\<\(\(max\|min\)-\)\=\(inline\|block\)-size\>"

syn match cssPositioningProp contained "\<inset\(\(-\(inline\|block\)\)\(-\(start\|end\)\)\=\)\=\>"

syn match cssPseudoClassId contained  "\<marker\>"


