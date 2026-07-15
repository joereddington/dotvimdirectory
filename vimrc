" =========================
" .vimrc File
" Author: Joe Reddington
" Description: Personal Vim configuration
" =========================
"

" General references: 
" * https://marcgg.com/blog/2016/03/01/vimrc-example/ 


set shell=/bin/bash
set nocompatible "doens't try and do what VI does 
execute pathogen#infect() 
filetype on
filetype plugin on
syntax on
set shiftwidth=2
set tabstop=2
set expandtab
set backspace=indent,eol,start "make backspace work properly per https://vi.stackexchange.com/a/2163/8792
set number
set hidden "Means we can have multiple hidden buffers
set thesaurus=$VIMHOME/mthesaur.txt
set dictionary=~/.vim/roget13a.txt
set history=5000 
set hlsearch "highlight search results 
set showmatch "When a bracket is inserted, breifly jump to the matching one. 
set ignorecase smartcase  "setting up search 
set guifont=Menlo\ Regular:h20 "set font 
set wildmenu "Show suggestions when doing completion in command mode. 
set directory=~/Downloads "Put all the swap files in a clearable directory 
set title "So that showcuts wordks

" START SPELLING SECTION
set spell "Add spell checking 
set spellsuggest=double " More thorough spelling suggestions 
hi clear SpellBad "clear the highlighing for badly spelled words 
hi SpellBad cterm=underline "set the highlighintg for badly spelt words 
"  END SPELLING SECTION 


" START LOG COMMANDS TODO: have these only activate for *.md files 
iabbrev lnn <C-R>=strftime('## %d/%m/%y %H:%M,')<C-M>
noremap lnm  0yypEEWdW.f,C,
map lnu :s/\(^.\{12}\d\d:\d\d\).\{-},/\1 to =strftime('%H:%M'),/g <bar> :nohlsearch <bar>f,l
iabbrev SAS <C-R>=strftime('- %d/%m/%y smallest next step: ')<C-M>
inoremap lnp ![Images description]({% link assets/images/ %})/Imaci]
noremap lnc 0f y$ :r !python3  "/home/joe/git/watson/command_list.py" """
noremap lnh 0f y$ :r !"/home/joe/git/historycode/history_list.sh" """
" END LOG COMMANDS 

" Map 'lnd' to list current titles of Firefox windows
iabbrev lnn <C-R>=strftime('## %d/%m/%y %H:%M,')<C-M>

"If you are wondering lna and the related code are in the delores.vim plugin
"in the plugin directory 



let g:CommandTMaxFiles=300000 "Part of the Command-T plugin (which I should investigate)

"My subsitutions 
inoremap jk <esc>
nnoremap gp `[v`] 
"gp is from https://stackoverflow.com/a/4313335/170243
set t_BE=
"set t_BE= is there to stop the "[200" issue
"





au BufRead,BufNewFile *odo.txt setlocal nowrap

" It would be good to wrap the autocommands in groups as per
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html 


"from
"https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE 
"These should improve autocomplete 
"The first step to "improve" the menu behavior is to execute this command:
"
set completeopt=longest,menuone
"
"The above command will change the 'completeopt' option so that Vim's popup
"menu doesn't select the first completion item, but rather just inserts the
"longest common text of all matches; and the menu will come up even if there's
"only one match. (The longest setting is responsible for the former effect and
"the menuone is responsible for the latter.)
"
"The next enhancement is the following mapping:
"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"The above mapping will change the behavior of the <Enter> key when the popup
"menu is visible. In that case the Enter key will simply select the
"highlighted menu item, just as <C-Y> does.
"
"These two mappings further improve the completion popup menu:
"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"In the above mappings, the first will make <C-N> work the way it normally
"does; however, when the menu appears, the <Down> key will be simulated. What
"this accomplishes is it keeps a menu item always highlighted. This way you
"can keep typing characters to narrow the matches, and the nearest match will
"be selected so that you can hit Enter at any time to insert it. In the above
"mappings, the second one is a little more exotic: it simulates <C-X><C-O> to
"bring up the omni completion menu, then it simulates <C-N><C-P> to remove the
"longest common text, and finally it simulates <Down> again to keep a match
"highlighted. 

"strikeout" 

"NOw Joe's own bit of autocomplete
set complete=.,w,b,u,t,i,k



"Showcommand 
set showcmd


" To get taglist working via https://vi.stackexchange.com/a/31712/8792
let tlist_markdown_settings = 'markdown;f:Heading'
let Tlist_Auto_Open = 1


"netrw comments from https://shapeshed.com/vim-netrw/
let g:netrw_browse_split = 4 "Open in split 
let g:netrw_winsize=25 "Take up 25%
let g:netrw_list_hide='.*.swp*' "hide these files 






"from https://vim.fandom.com/wiki/Make_footnotes_in_vim
inoremap ,f <Esc>:call VimFootnotes()<CR>
function! VimFootnotes()
  execute "normal ma"
  let footNoteText = input("enter text for footnote: ")
  if exists("b:vimfootnotenumber")
    let b:vimfootnotenumber = b:vimfootnotenumber + 1
    let cr = ""
  else
    let b:vimfootnotenumber = 0
    let cr = "\<CR>"
  endif
  let b:pos = line('.').' | normal! '.virtcol('.').'|'.'4l'
  exe "normal a".b:vimfootnotenumber."S\<Esc>"
  if search("-- $", "b")
    exe "normal o".cr."".b:vimfootnotenumber."S " . footNoteText
  else
    exe "normal o".cr."".b:vimfootnotenumber."S " . footNoteText
  endif
  execute "normal `aA"
endfunction


"Write with sudo
"
" Sample command W
" 
command SW :execute ':silent w !sudo tee % > /dev/null' | :edit!


:set viminfo=!,'10000,<50,s10,h,:10000  "apparently increses the size of the command history

set mouse=a


"Commands for img-paste
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
"let g:mdip_imgdir = 'images'
"let g:mdip_imgname = 'image'

let g:mdip_imgdir_absolute =  '/home/joe/git/joereddington.github.io/assets/images/'
let g:mdip_imgdir_intext = '/assets/images'
if has("mac")
  let g:mdip_imgdir_absolute =  '/Users/ppac065/git/joereddington.github.io/assets/images'
  let g:mdip_imgdir_intext = '/assets/images'
endif

" from https://github.com/onivim/oni/issues/2342 to solve the issue mentioned:
"  
" that shift and space renders as ;2u
" https://github.com/onivim/oni/issues/2342
tnoremap <s-space> <space>



" Set the terminal title to include "vim" when entering Vim ( I don't know if
" this does anything
autocmd VimEnter * call system("printf '\033]0;vim %s\007' " .  expand("%:t"))


noremap ,ny :! /bin/bash /home/joe/git/delores/from_command_line.sh y<cr>




"fix the wildmode
set wildmode=longest,list


"Themes and colours 
nnoremap <PageUp> :CycleColorNext<CR>
nnoremap <PageDown> :CycleColorPrev<CR>

"Custom command for processing inbox 
function! MoveSelectionToDiary()
    " Cut the selected text and store in register a
    normal! "ay

    " Open diary/index.md, move to the end, paste the text
    execute 'silent! e diary/index.md'
    execute 'normal! Go'
    normal! "ap
    " Save the changes
    execute 'silent! w'

    " Return to the original file
    execute 'b#'
endfunction

" Map a key combination to the function MoveSelectionToDiary above
vnoremap <leader>m d:split diary/index.mdG$p:w:q

"Make latex files o
autocmd FileType tex setlocal makeprg=make

let g:todo_done_filename = 'done.txt'

"Yes I did this ✓ 
"I have put this in the stack to do later ⏳
" I will NOT do this 🚫
" I don't know about this one 📥

nnoremap <leader>1 r✓
"For skim 
let g:vimtex_view_method = 'skim'
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_activate = 1

let g:vimtex_quickfix_ignore_filters = [
      \ 'Overfull \\hbox',
      \ ]



" ## 16/01/26 22:16, I've started using ctrl-Z a lot more so I want to remove
" the muscel memory for ZZ
 nnoremap ZZ <Nop>

