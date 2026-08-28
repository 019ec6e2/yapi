" ayu2 airline theme — Ayu v2 dark palette, matches ~/.vim/colors/ayu2.vim

let s:BG     = '#0B0E14'   " editor bg
let s:PANEL  = '#0F131A'   " panel bg
let s:FG     = '#BFBDB6'   " normal fg
let s:FUNC   = '#FFB454'   " yellow
let s:STRING = '#AAD94C'   " green
let s:CONST  = '#D2A6FF'   " purple
let s:MARKUP = '#F07178'   " red
let s:ERROR  = '#D95757'

" Normal mode
let s:N1 = [ s:BG , s:FUNC   , 233 , 214 ]
let s:N2 = [ s:FG , s:PANEL  , 250 , 234 ]
let s:N3 = [ s:FG , s:BG     , 250 , 233 ]

" Insert mode
let s:I1 = [ s:BG , s:STRING , 233 , 148 ]
let s:I2 = [ s:FG , s:PANEL  , 250 , 234 ]
let s:I3 = [ s:FG , s:BG     , 250 , 233 ]

" Visual mode
let s:V1 = [ s:BG , s:CONST  , 233 , 171 ]
let s:V2 = [ s:FG , s:PANEL  , 250 , 234 ]
let s:V3 = [ s:FG , s:BG     , 250 , 233 ]

" Replace mode
let s:RE = [ s:BG , s:MARKUP , 233 , 203 ]

let g:airline#themes#ayu2#palette = {}

let g:airline#themes#ayu2#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#ayu2#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#ayu2#palette.insert_replace = {
            \ 'airline_a': [ s:RE[0]   , s:I1[1]   , s:RE[2]   , s:I1[3]   , ''     ] }

let g:airline#themes#ayu2#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

let g:airline#themes#ayu2#palette.replace = copy(g:airline#themes#ayu2#palette.normal)
let g:airline#themes#ayu2#palette.replace.airline_a = [ s:RE[0] , s:RE[1] , s:RE[2] , s:RE[3] , '' ]

" Inactive windows
let s:IA = [ s:PANEL , s:PANEL , 234 , 234 , '' ]
let g:airline#themes#ayu2#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#ayu2#palette.inactive.airline_z = [ s:PANEL , s:BG , 234 , 233 , '' ]

" ALE / diagnostics accents
let g:airline#themes#ayu2#palette.normal.airline_error   = [ s:BG , s:ERROR , 233 , 203 ]
let g:airline#themes#ayu2#palette.normal.airline_warning = [ s:BG , s:FUNC  , 233 , 214 ]
let g:airline#themes#ayu2#palette.insert.airline_error   = [ s:BG , s:ERROR , 233 , 203 ]
let g:airline#themes#ayu2#palette.insert.airline_warning = [ s:BG , s:FUNC  , 233 , 214 ]
let g:airline#themes#ayu2#palette.visual.airline_error   = [ s:BG , s:ERROR , 233 , 203 ]
let g:airline#themes#ayu2#palette.visual.airline_warning = [ s:BG , s:FUNC  , 233 , 214 ]
let g:airline#themes#ayu2#palette.replace.airline_error  = [ s:BG , s:ERROR , 233 , 203 ]
let g:airline#themes#ayu2#palette.replace.airline_warning = [ s:BG , s:FUNC , 233 , 214 ]
