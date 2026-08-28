" ayu2.vim — Ayu v2 (dark) for plain Vim
" Port of Shatur/neovim-ayu (lua) to vimscript, using the official
" ayu-theme/ayu-colors v2 palette. Matches base16-ayu-dark used by
" tinted-tmux and the alacritty palette (bg #0B0E14).
" License: GPL-3.0 (same as Shatur/neovim-ayu)

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "ayu2"

" --- Palette (Shatur/neovim-ayu lua/ayu/colors.lua, dark variant) ---
let s:c = {}
let s:c.bg                 = '#0B0E14'
let s:c.fg                 = '#BFBDB6'
let s:c.accent             = '#E6B450'
let s:c.tag                = '#39BAE6'
let s:c.func               = '#FFB454'
let s:c.entity             = '#59C2FF'
let s:c.string             = '#AAD94C'
let s:c.regexp             = '#95E6CB'
let s:c.markup             = '#F07178'
let s:c.keyword            = '#FF8F40'
let s:c.special            = '#E6B673'
let s:c.comment            = '#636A72'
let s:c.constant           = '#D2A6FF'
let s:c.operator           = '#F29668'
let s:c.error              = '#D95757'
let s:c.line               = '#11151C'
let s:c.panel_bg           = '#0F131A'
let s:c.panel_shadow       = '#05070A'
let s:c.panel_border       = '#000000'
let s:c.gutter_normal      = '#454B55'
let s:c.guide_normal       = '#1E222A'
let s:c.selection_bg       = '#1B3A5B'
let s:c.selection_inactive = '#122132'
let s:c.vcs_added          = '#7FD962'
let s:c.vcs_modified       = '#73B8FF'
let s:c.vcs_removed        = '#F26D78'
let s:c.vcs_added_bg       = '#1D2214'
let s:c.vcs_removed_bg     = '#2D2220'
let s:c.fg_idle            = '#565B66'
let s:c.warning            = '#FF8F40'
let s:c.white              = '#FFFFFF'
let s:c.black              = '#000000'

" --- Base UI ---
exe 'hi Normal          guifg=' . s:c.fg        . ' guibg=' . s:c.bg           . ' gui=NONE'
exe 'hi NormalFloat     guibg=' . s:c.bg
exe 'hi FloatBorder     guifg=' . s:c.comment
exe 'hi FloatTitle      guifg=' . s:c.fg
exe 'hi ColorColumn     guibg=' . s:c.line
exe 'hi Cursor          guifg=' . s:c.bg        . ' guibg=' . s:c.fg
exe 'hi CursorColumn    guibg=' . s:c.line
exe 'hi CursorLine      guibg=' . s:c.line
exe 'hi CursorLineNr    guifg=' . s:c.accent    . ' guibg=' . s:c.line         . ' gui=NONE'
exe 'hi LineNr          guifg=' . s:c.guide_normal             . ' guibg=' . s:c.bg
exe 'hi Directory       guifg=' . s:c.func
exe 'hi ErrorMsg        guifg=' . s:c.error
exe 'hi WinSeparator    guifg=' . s:c.panel_border . ' guibg=' . s:c.bg
hi def link VertSplit   WinSeparator
exe 'hi Folded          guifg=' . s:c.fg_idle   . ' guibg=' . s:c.panel_bg
exe 'hi FoldColumn      guibg=' . s:c.bg
exe 'hi SignColumn      guibg=' . s:c.bg
exe 'hi MatchParen      guifg=NONE guibg=NONE gui=underline guisp=' . s:c.func
exe 'hi ModeMsg         guifg=' . s:c.string
exe 'hi MoreMsg         guifg=' . s:c.string
exe 'hi NonText         guifg=' . s:c.guide_normal
exe 'hi Pmenu           guifg=' . s:c.fg        . ' guibg=' . s:c.selection_inactive
exe 'hi PmenuSel        guifg=' . s:c.fg        . ' guibg=' . s:c.selection_inactive . ' gui=reverse'
exe 'hi Question        guifg=' . s:c.string
exe 'hi Search          guifg=' . s:c.bg        . ' guibg=' . s:c.constant
exe 'hi CurSearch       guifg=' . s:c.bg        . ' guibg=' . s:c.special
exe 'hi IncSearch       guifg=' . s:c.keyword   . ' guibg=' . s:c.selection_inactive
exe 'hi SpecialKey      guifg=' . s:c.selection_inactive
exe 'hi SpellCap        guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.tag
exe 'hi SpellLocal      guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.keyword
exe 'hi SpellBad        guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.error
exe 'hi SpellRare       guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.regexp
exe 'hi StatusLine      guifg=' . s:c.fg        . ' guibg=' . s:c.panel_bg     . ' gui=NONE'
exe 'hi StatusLineNC    guifg=' . s:c.fg_idle   . ' guibg=' . s:c.panel_bg     . ' gui=NONE'
exe 'hi WildMenu        guifg=' . s:c.fg        . ' guibg=' . s:c.markup
exe 'hi TabLine         guifg=' . s:c.comment   . ' guibg=' . s:c.panel_shadow . ' gui=NONE'
exe 'hi TabLineFill     guifg=' . s:c.fg        . ' guibg=' . s:c.panel_border
exe 'hi TabLineSel      guifg=' . s:c.fg        . ' guibg=' . s:c.bg           . ' gui=NONE'
exe 'hi Title           guifg=' . s:c.keyword
exe 'hi Visual          guibg=' . s:c.selection_inactive
exe 'hi WarningMsg      guifg=' . s:c.warning
exe 'hi Conceal         guifg=' . s:c.comment
exe 'hi qfLineNr        guifg=' . s:c.keyword
exe 'hi qfError         guifg=' . s:c.error

" --- Syntax ---
exe 'hi Comment         guifg=' . s:c.comment    . ' gui=italic'
exe 'hi Constant        guifg=' . s:c.constant
exe 'hi String          guifg=' . s:c.string
exe 'hi Identifier      guifg=' . s:c.entity     . ' gui=NONE'
exe 'hi Function        guifg=' . s:c.func
exe 'hi Statement       guifg=' . s:c.keyword    . ' gui=NONE'
exe 'hi Operator        guifg=' . s:c.operator
exe 'hi Exception       guifg=' . s:c.markup
exe 'hi PreProc         guifg=' . s:c.accent
exe 'hi Type            guifg=' . s:c.entity     . ' gui=NONE'
exe 'hi Structure       guifg=' . s:c.special
exe 'hi Special         guifg=' . s:c.accent
exe 'hi Delimiter       guifg=' . s:c.special
exe 'hi Underlined      guifg=NONE guibg=NONE gui=underline guisp=' . s:c.tag
exe 'hi Ignore          guifg=' . s:c.fg
exe 'hi Error           guifg=' . s:c.white      . ' guibg=' . s:c.error
exe 'hi Todo            guifg=' . s:c.markup
exe 'hi markdownCode    guifg=' . s:c.special

" --- Diff / VCS ---
exe 'hi Added           guifg=' . s:c.vcs_added
exe 'hi Removed         guifg=' . s:c.vcs_removed
exe 'hi Changed         guifg=' . s:c.vcs_modified
exe 'hi DiffAdd         guibg=' . s:c.vcs_added_bg
exe 'hi DiffAdded       guifg=' . s:c.vcs_added
exe 'hi DiffDelete      guibg=' . s:c.vcs_removed_bg
exe 'hi DiffRemoved     guifg=' . s:c.vcs_removed
exe 'hi DiffText        guibg=' . s:c.gutter_normal
exe 'hi DiffChange      guibg=' . s:c.selection_inactive

" --- Diagnostics (ALE uses these links) ---
exe 'hi DiagnosticError guifg=' . s:c.error
exe 'hi DiagnosticWarn  guifg=' . s:c.keyword
exe 'hi DiagnosticInfo  guifg=' . s:c.tag
exe 'hi DiagnosticHint  guifg=' . s:c.regexp
exe 'hi DiagnosticUnderlineError guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.error
exe 'hi DiagnosticUnderlineWarn  guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.keyword
exe 'hi DiagnosticUnderlineInfo  guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.tag
exe 'hi DiagnosticUnderlineHint  guifg=NONE guibg=NONE gui=undercurl guisp=' . s:c.regexp

" --- In-buffer terminal (:terminal) ---
let g:terminal_color_0  = s:c.bg
let g:terminal_color_1  = s:c.markup
let g:terminal_color_2  = s:c.string
let g:terminal_color_3  = s:c.accent
let g:terminal_color_4  = s:c.tag
let g:terminal_color_5  = s:c.constant
let g:terminal_color_6  = s:c.regexp
let g:terminal_color_7  = s:c.fg
let g:terminal_color_8  = s:c.fg_idle
let g:terminal_color_9  = s:c.error
let g:terminal_color_10 = s:c.string
let g:terminal_color_11 = s:c.accent
let g:terminal_color_12 = s:c.tag
let g:terminal_color_13 = s:c.constant
let g:terminal_color_14 = s:c.regexp
let g:terminal_color_15 = s:c.comment
let g:terminal_color_background = s:c.bg
let g:terminal_color_foreground = s:c.fg

" vim: set tw=0:
