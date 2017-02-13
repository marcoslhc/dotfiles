" Vim color file
" Maintainer:   Marcos Hernandez <marcoslhc@gmail.com>
" Last Change:
" URL:

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" based in https://github.com/joshdick/onedark.vim/blob/master/colors/onedark.vim

" [-------------------------- Color scheme -------------------------]
" +------------------+-------------------------+-------------+
" |      Color       |     HEX     |   CTERM   |     RGB     |
" +------------------+-------------+-------------------------+
" | very-light-grey  | #c5c6c6     | 251       | 198,198,198 |
" | light-grey       | #959696     | 246       | 148,148,148 |
" | grey             | #454646     | 238       |  68, 68, 68 |
" | dark-grey        | #292a2a     | 236       |  48, 48, 48 |
" | very-dark-grey   | #1d1f1f     | 234       |  48, 48, 48 |
" | cyan             | #5fdfdf     |  80       |  95,215,215 |
" | blue             | #00afff     |  39       |             |
" | purple           | #8700df     |  92       |             |
" | green            | #87df00     | 112       |             |
" | magent           | #ff0087     | 198       |             |
" | red              | #af005f     |
" | orange           | #df5f00     | 166       |             |
" | light-orange     | #FF8700     | 208       |             |
" | yellow           | #ffdf00     | 220       |             |
" +------------------+-------------+-----------+-------------+

let s:palette = {
  \  "fg":              ["fg","fg"],
  \  "bg":              ["bg","bg"],
  \  "white":           ["#eeeeee", "255"],
  \  "very_light_grey": ["#c6c6c6", "251"],
  \  "light_grey":      ["#949494", "246"],
  \  "grey":            ["#4e4e4e", "238"],
  \  "dark_grey":       ["#262626", "236"],
  \  "very_dark_grey":  ["#1c1c1c", "234"],
  \  "turquoise":       ["#008787",  "30"],
  \  "cyan":            ["#5fdfdf",  "80"],
  \  "blue":            ["#00afff",  "39"],
  \  "purple":          ["#8700df",  "92"],
  \  "green":           ["#87df00", "112"],
  \  "red":             ["#af005f", "125"],
  \  "orange":          ["#df5f00", "166"],
  \  "light_orange":    ["#FF8700", "208"],
  \  "yellow":          ["#ffdf00", "220"],
  \  "textFg":          ["#eeeeee", "255"],
  \  "textBg":          ["#1c1c1c", "234"],
  \  "diffAddFg":       ["#005f00",  "22"],
  \  "diffAddBg":       ["#afff6f", "155"],
  \  "diffDeleteFg":    ["#870044",  "88"],
  \  "diffDeleteBg":    ["#ff5faf", "205"],
  \  "diffChangeFg":    ["#1c1c1c", "234"],
  \  "diffChangeBg":    ["#ffff87", "228"],
  \  "diffTextFg":      ["#1c1c1c", "234"],
  \  "diffTextBg":      ["#ffdf00", "220"]
  \ }

fun! s:guiColor(colorName)
 return s:getColor("gui", a:colorName)
endfunction

fun! s:ctermColor(colorName)
 return s:getColor("cterm", a:colorName)
endfunction

fun! s:getColor(context, colorName)
  if (a:colorName == "NONE")
    return "NONE"
  endif
  let l:idx = (a:context == "gui" ? 0 : 1)
  return (has_key(s:palette, a:colorName) ? get(s:palette, a:colorName)[l:idx] : "NONE")
endfunction

highlight clear

if exists("syntax_on")
   syntax reset
endif

set t_Co=256

let g:colors_name="newton"

if !exists("g:newton_termcolors")
    let g:newton_termcolors = 256
endif

if !exists("g:newton_terminal_italics")
    let g:newton_terminal_italics = 0
endif

" [ replace highlight function ]: {{{
fun! s:h(group, style)
    if g:newton_terminal_italics == 0
        if has_key(a:style, "attr") && a:style["attr"] == "italic"
            unlet a:style.attr
        endif
    endif
    if g:newton_termcolors == 16
        let l:ctermfg = (has_key(a:style "fg") ? a:style.fg.cterm16 : "NONE")
        let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
    else
        let l:ctermfg = (has_key(a:style, "fg") ? s:ctermColor(a:style.fg) : "NONE")
        let l:ctermbg = (has_key(a:style, "bg") ? s:ctermColor(a:style.bg) : "NONE")
    endif
    execute     "highlight" a:group
        \       "guifg=" (has_key(a:style, "fg") ? s:guiColor(a:style.fg)   : "NONE")
         \      "guibg=" (has_key(a:style, "bg") ? s:guiColor(a:style.bg)   : "NONE")
          \     "guisp=" (has_key(a:style, "sp") ? s:guiColor(a:style.sp)   : "NONE")
           \    "gui="   (has_key(a:style, "attr") ? a:style.attr   : "NONE")
            \   "ctermfg=" . l:ctermfg
             \  "ctermbg=" . l:ctermbg
              \ "cterm=" (has_key(a:style, "attr") ? a:style.attr    : "NONE")
endfun
" }}}


" Uncomment and complete the commands you want to change from the default.
call s:h("Normal",         { "fg": "textFg", "bg": "textBg", "attr": "bold"})
"hi Cursor
"hi CursorIM
call s:h("CursorLineNR",   { "fg": "yellow", "bg": "dark_grey", "attr": "underline", "guisp": "fg", "ctermsp" : "fg" })
call s:h("CursorLine",     { "bg": "grey" })
call s:h("DiffAdd",        { "fg": "diffAddFg",    "bg": "diffAddBg" })
call s:h("DiffChange",     { "fg": "diffChangeFg", "bg": "diffChangeBg" })
call s:h("DiffDelete",     { "fg": "diffDeleteFg", "bg": "diffDeleteBg" })
call s:h("DiffText",       { "fg": "diffTextFg",   "bg": "diffTextBg," })
call s:h("diffAdded",      { "fg": "diffAddFg",    "bg": "diffAddBg" })
call s:h("diffRemoved",    { "fg": "diffDeleteFg", "bg": "diffDeleteBg" })
call s:h("ErrorMsg",       { "fg": "red" })
call s:h("VertSplit",      { "fg": "grey", "bg": "very_dark_grey" })
"hi Folded
"hi FoldColumn
"hi IncSearch
call s:h("LineNr",         { "fg": "light_grey", "bg": "very_dark_grey" })
call s:h("ModeMsg",        { "fg": "green" })
call s:h("MoreMsg",        { "fg": "green" })
"hi NonText
"hi Question
"hi Search
"hi SignColumn
"hi SpecialKey
"hi StatusLine
"hi StatusLineNC
"hi Title
"hi Visual
"hi VisualNOS
"hi WarningMsg
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip
call s:h("Directory",      { "fg": "turquoise", "attr": "bold" })

" syntax highlighting groups
call s:h("Comment",        { "fg": "light_grey",  "bg": "very_dark_grey", "attr": "italic" })
call s:h("Constant",       { "fg": "orange" })
call s:h("String",         { "fg": "yellow" })
call s:h("Character",      { "fg": "yellow" })
call s:h("Number",         { "fg": "cyan" })
call s:h("Boolean",        { "fg": "purple" })
call s:h("Float",          { "fg": "cyan" })
call s:h("Identifier",     { "fg": "light_orange" })
call s:h("Function",       { "fg": "cyan" })
call s:h("Statement",      { "fg": "red" })
call s:h("Conditional",    { "fg": "red" })
call s:h("Repeat",         { "fg": "red" })
call s:h("Label",          { "fg": "red" })
call s:h("Operator",       { "fg": "red" })
call s:h("Keyword",        { "fg": "red" })
call s:h("Exception",      { "fg": "red" })
call s:h("PreProc",        { "fg": "purple" })
call s:h("Include",        { "fg": "purple" })
call s:h("Define",         { "fg": "purple" })
call s:h("Macro",          { "fg": "purple" })
call s:h("PreCondit",      { "fg": "purple" })
call s:h("Type",           { "fg": "yellow" })
call s:h("StorageClass",   { "fg": "yellow" })
call s:h("Structure",      { "fg": "yellow" })
call s:h("Typedef",        { "fg": "yellow" })
call s:h("Special",        { "fg": "light_orange" })
call s:h("SpecialChar",    { "fg": "light_orange" })
call s:h("Tag",            { "fg": "light_orange" })
call s:h("Delimiter",      { "fg": "light_orange" })
call s:h("SpecialComment", { "fg": "white", "attr": "bold" })
call s:h("Debug",          { "fg": "orange", "bg": "yellow" })
call s:h("Underlined",     { "fg": "blue", "attr": "underline", "sp": "fg"})
"hi Ignore
call s:h("Error",          { "fg": "purple", "bg": "red" })
"hi Todo

call s:h("Pmenu",          { "fg": "very_dark_grey", "bg": "white" })
call s:h("PmenuSel",      { "fg": "white", "bg": "blue", "attr": "bold" })
call s:h("PmenuSbar",      { "fg": "grey", "bg": "grey" })
call s:h("PmenuThum",      { "fg": "blue", "bg": "blue" })

" [----------------- Syntax ------------------------]: {{{
call s:h("cssAttrComma",         { "fg": "purple" })
call s:h("cssAttributeSelector", { "fg": "green" })
call s:h("cssBraces",            { "fg": "white" })
call s:h("cssClassName",         { "fg": "yellow" })
call s:h("cssClassNameDot",      { "fg": "yellow" })
call s:h("cssDefinition",        { "fg": "purple" })
call s:h("cssFontAttr",          { "fg": "yellow" })
call s:h("cssFontDescriptor",    { "fg": "purple" })
call s:h("cssFunctionName",      { "fg": "blue" })
call s:h("cssIdentifier",        { "fg": "blue" })
call s:h("cssImportant",         { "fg": "purple" })
call s:h("cssInclude",           { "fg": "white" })
call s:h("cssIncludeKeyword",    { "fg": "purple" })
call s:h("cssMediaType",         { "fg": "yellow" })
call s:h("cssProp",              { "fg": "white" })
call s:h("cssPseudoClassId",     { "fg": "yellow" })
call s:h("cssSelectorOp",        { "fg": "purple" })
call s:h("cssSelectorOp2",       { "fg": "purple" })
call s:h("cssTagName",           { "fg": "red" })

" HTML
call s:h("htmlTitle",          { "fg": "white" })
call s:h("htmlArg",            { "fg": "yellow" })
call s:h("htmlEndTag",         { "fg": "white" })
call s:h("htmlH1",             { "fg": "white" })
call s:h("htmlLink",           { "fg": "purple" })
call s:h("htmlSpecialChar",    { "fg": "yellow" })
call s:h("htmlSpecialTagName", { "fg": "red" })
call s:h("htmlTag",            { "fg": "white" })
call s:h("htmlTagName",        { "fg": "red" })

" JavaScript
call s:h("javaScriptBraces",     { "fg": "white" })
call s:h("javaScriptFunction",   { "fg": "purple" })
call s:h("javaScriptIdentifier", { "fg": "blue" })
call s:h("javaScriptNull",       { "fg": "yellow" })
call s:h("javaScriptNumber",     { "fg": "yellow" })
call s:h("javaScriptRequire",    { "fg": "cyan" })
call s:h("javaScriptReserved",   { "fg": "purple" })
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction",      { "fg": "purple" })
call s:h("jsClassKeyword",       { "fg": "yellow" })
call s:h("jsClassMethodType",    { "fg": "blue" })
call s:h("jsDocParam",           { "fg": "blue" })
call s:h("jsDocTags",            { "fg": "purple" })
call s:h("jsExport",             { "fg": "purple" })
call s:h("jsExportDefault",      { "fg": "purple" })
call s:h("jsExtendsKeyword",     { "fg": "purple" })
call s:h("jsFrom",               { "fg": "purple" })
call s:h("jsFuncCall",           { "fg": "blue" })
call s:h("jsFunction",           { "fg": "purple" })
call s:h("jsGlobalObjects",      { "fg": "yellow" })
call s:h("jsImport",             { "fg": "purple" })
call s:h("jsModuleAs",           { "fg": "purple" })
call s:h("jsModuleWords",        { "fg": "purple" })
call s:h("jsModules",            { "fg": "purple" })
call s:h("jsNull",               { "fg": "yellow" })
call s:h("jsOperator",           { "fg": "purple" })
call s:h("jsStorageClass",       { "fg": "purple" })
call s:h("jsSuper",              { "fg": "red" })
call s:h("jsTemplateBraces",     { "fg": "red" })
call s:h("jsTemplateVar",        { "fg": "green" })
call s:h("jsThis",               { "fg": "red" })
call s:h("jsUndefined",          { "fg": "yellow" })
" https://github.com/othree/yajs.vim
call s:h("javascriptArrowFunc",    { "fg": "purple" })
call s:h("javascriptClassExtends", { "fg": "purple" })
call s:h("javascriptClassKeyword", { "fg": "purple" })
call s:h("javascriptDocNotation",  { "fg": "purple" })
call s:h("javascriptDocParamName", { "fg": "blue" })
call s:h("javascriptDocTags",      { "fg": "purple" })
call s:h("javascriptEndColons",    { "fg": "white" })
call s:h("javascriptExport",       { "fg": "purple" })
call s:h("javascriptFuncArg",      { "fg": "white" })
call s:h("javascriptFuncKeyword",  { "fg": "purple" })
call s:h("javascriptIdentifier",   { "fg": "red" })
call s:h("javascriptImport",       { "fg": "purple" })
call s:h("javascriptMethodName",   { "fg": "white" })
call s:h("javascriptObjectLabel",  { "fg": "white" })
call s:h("javascriptOpSymbol",     { "fg": "cyan" })
call s:h("javascriptOpSymbols",    { "fg": "cyan" })
call s:h("javascriptPropertyName", { "fg": "green" })
call s:h("javascriptTemplateSB",   { "fg": "red" })
call s:h("javascriptVariable",     { "fg": "purple" })

" JSON
call s:h("jsonCommentError", { "fg": "white" })
call s:h("jsonKeyword", { "fg": "red" })
call s:h("jsonBoolean", { "fg": "yellow" })
call s:h("jsonNumber", { "fg": "yellow" })
call s:h("jsonQuote", { "fg": "white" })
call s:h("jsonMissingCommaError", { "fg": "red", "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": "red", "gui": "reverse" })
call s:h("jsonNumError", { "fg": "red", "gui": "reverse" })
call s:h("jsonString", { "fg": "green" })
call s:h("jsonStringSQError", { "fg": "red", "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": "red", "gui": "reverse" })

" Markdown
call s:h("markdownCode", { "fg": "green" })
call s:h("markdownCodeBlock", { "fg": "green" })
call s:h("markdownCodeDelimiter", { "fg": "green" })
call s:h("markdownHeadingDelimiter", { "fg": "red" })
call s:h("markdownRule", { "fg": "light_grey" })
call s:h("markdownHeadingRule", { "fg": "light_grey" })
call s:h("markdownH1", { "fg": "red" })
call s:h("markdownH2", { "fg": "red" })
call s:h("markdownH3", { "fg": "red" })
call s:h("markdownH4", { "fg": "red" })
call s:h("markdownH5", { "fg": "red" })
call s:h("markdownH6", { "fg": "red" })
call s:h("markdownIdDelimiter", { "fg": "purple" })
call s:h("markdownId", { "fg": "purple" })
call s:h("markdownBlockquote", { "fg": "light_grey" })
call s:h("markdownItalic", { "fg": "purple", "gui": "italic", "cterm": "italic" })
call s:h("markdownBold", { "fg": "yellow", "gui": "bold", "cterm": "bold" })
call s:h("markdownListMarker", { "fg": "red" })
call s:h("markdownOrderedListMarker", { "fg": "red" })
call s:h("markdownIdDeclaration", { "fg": "blue" })
call s:h("markdownLinkText", { "fg": "blue" })
call s:h("markdownLinkDelimiter", { "fg": "white" })
call s:h("markdownUrl", { "fg": "purple" })

" PHP
call s:h("phpVarSelector", { "fg": "red" })
call s:h("phpOperator", { "fg": "white" })
call s:h("phpParent", { "fg": "white" })
call s:h("phpMemberSelector", { "fg": "white" })
call s:h("phpType", { "fg": "purple" })
call s:h("phpKeyword", { "fg": "purple" })
call s:h("phpClass", { "fg": "yellow" })
call s:h("phpUseClass", { "fg": "white" })
call s:h("phpUseAlias", { "fg": "white" })
call s:h("phpInclude", { "fg": "purple" })
call s:h("phpClassExtends", { "fg": "green" })
call s:h("phpDocTags", { "fg": "white" })
call s:h("phpFunction", { "fg": "blue" })
call s:h("phpFunctions", { "fg": "cyan" })
call s:h("phpMethodsVar", { "fg": "yellow" })
call s:h("phpMagicConstants", { "fg": "yellow" })
call s:h("phpSuperglobals", { "fg": "red" })
call s:h("phpConstants", { "fg": "yellow" })

" Ruby
call s:h("rubyBlockParameter", { "fg": "red"})
call s:h("rubyBlockParameterList", { "fg": "red" })
call s:h("rubyClass", { "fg": "purple"})
call s:h("rubyConstant", { "fg": "yellow"})
call s:h("rubyControl", { "fg": "purple" })
call s:h("rubyEscape", { "fg": "red"})
call s:h("rubyFunction", { "fg": "blue"})
call s:h("rubyGlobalVariable", { "fg": "red"})
call s:h("rubyInclude", { "fg": "blue"})
call s:h("rubyIncluderubyGlobalVariable", { "fg": "red"})
call s:h("rubyInstanceVariable", { "fg": "red"})
call s:h("rubyInterpolation", { "fg": "cyan" })
call s:h("rubyInterpolationDelimiter", { "fg": "red" })
call s:h("rubyInterpolationDelimiter", { "fg": "red"})
call s:h("rubyRegexp", { "fg": "cyan"})
call s:h("rubyRegexpDelimiter", { "fg": "cyan"})
call s:h("rubyStringDelimiter", { "fg": "green"})
call s:h("rubySymbol", { "fg": "cyan"})

" Sass
call s:h("sassAmpersand", { "fg": "red" })
call s:h("sassClass", { "fg": "yellow" })
call s:h("sassControl", { "fg": "purple" })
call s:h("sassExtend", { "fg": "purple" })
call s:h("sassFor", { "fg": "white" })
call s:h("sassFunction", { "fg": "cyan" })
call s:h("sassId", { "fg": "blue" })
call s:h("sassInclude", { "fg": "purple" })
call s:h("sassMedia", { "fg": "purple" })
call s:h("sassMediaOperators", { "fg": "white" })
call s:h("sassMixin", { "fg": "purple" })
call s:h("sassMixinName", { "fg": "blue" })
call s:h("sassMixing", { "fg": "purple" })

" TypeScript
call s:h("typescriptReserved", { "fg": "purple" })
call s:h("typescriptEndColons", { "fg": "white" })
call s:h("typescriptBraces", { "fg": "white" })

" XML
call s:h("xmlAttrib", { "fg": "yellow" })
call s:h("xmlEndTag", { "fg": "red" })
call s:h("xmlTag", { "fg": "red" })
call s:h("xmlTagName", { "fg": "red" })
" }}}

" [--------------- tpope/vim-fugitive -------------]: {{{
call s:h("diffAdded", { "fg": "diffAddFg", "bg": "diffAddBg" })
call s:h("diffRemoved", { "fg": "diffDeleteFg", "bg" : "diffDeleteBg" })
" }}}

" [---------------------- Git ----------------------]: {{{
call s:h("gitcommitComment", { "fg": "light_grey" })
call s:h("gitcommitUnmerged", { "fg": "green" })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": "purple" })
call s:h("gitcommitDiscardedType", { "fg": "red" })
call s:h("gitcommitSelectedType", { "fg": "yellow" })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": "cyan" })
call s:h("gitcommitDiscardedFile", { "fg": "red" })
call s:h("gitcommitSelectedFile", { "fg": "green" })
call s:h("gitcommitUnmergedFile", { "fg": "yellow" })
call s:h("gitcommitFile", {})
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile

" [ ----------------- NERDTree ---------------------]: {{{
call s:h("NERDTreeUp",          { "fg": "green" })
call s:h("NERDTreeHelpCommand", { "fg": "blue" })
call s:h("NERDTreeHelpTitle",   { "fg": "turquoise", "attr": "bold" })
call s:h("NERDTreeHelpKey",     { "fg": "green", "attr": "bold" })
call s:h("NERDTreeHelp",        { "fg": "light_grey" })
call s:h("NERDTreeToggleOff",   { "fg": "red" })
call s:h("NERDTreeToggleOn",    { "fg": "green" })
call s:h("NERDTreeDir",         { "fg": "turquoise", "attr": "bold" })
call s:h("NERDTreeDirSlash",    { "fg": "green" })
call s:h("NERDTreeFile",        { "fg": "very_light_grey" })
call s:h("NERDTreeExecFile",    { "fg": "green" })
call s:h("NERDTreeOpenable",    { "fg": "green" })
call s:h("NERDTreeClosable",    { "fg": "red" })
call s:h("NERDTreeCWD",         { "fg": "green" })
"}}}
set background=dark	" or light
