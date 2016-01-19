runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=85
let g:ackprg="ack-grep -H --nocolor --nogroup --column"


autocmd User Rails silent! Rnavcommand intializer config/initializers -suffix=.rb -glob=**/*

autocmd User Rails silent! Rnavcommand feature features/ -suffix=.feature -glob=**/*

autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions/ -glob=**/* -suffix=_steps.rb

autocmd User Rails silent! Rnavcommand sass app/assets/stylesheets/ -suffix=.css.sass -glob=*

autocmd User Rails silent! Rnavcommand specmodel  spec/models/ -suffix=_spec.rb -default=model() -glob=*

autocmd User Rails silent! Rnavcommand speccontroller spec/controllers/ -suffix=_controller_spec.rb -default=controller() -glob=*

autocmd User Rails silent! Rnavcommand spechelper spec/helpers/ -suffix=_helper_spec.rb -default=controller() -glob=*

autocmd User Rails silent! Rnavcommand specviews spec/views/ -glob=**/* -suffix=.html.haml_spec.rb -default=controller() -glob=*

autocmd User Rails silent! Rnavcommand factory spec/support/factories/ -glob=**/* -suffix=_factory.rb -default=model() -glob=*

" Vim functions to run RSpec and Cucumber on the current file and optionally
" on the spec/scenario under the cursor.

function! RailsScriptIfExists(name)
  execute ":Rvm use"
  return  a:name
endfunction

function! RunSpec(args)
	let spec = RailsScriptIfExists("rspec --color -f d")
	let cmd = spec . " " . a:args . " " . @%
  execute ":! echo " . cmd . " && " . cmd
endfunction

function! RunCucumber(args)
	let cucumber = RailsScriptIfExists("cucumber")
	let cmd = cucumber . " " . @% . a:args
	execute ":! echo " . cmd . " && " . cmd
endfunction

function! RunTestFile(args)
	if @% =~ "\.feature$"
		call RunCucumber("" . a:args)
	elseif @% =~ "\.rb$"
		call RunSpec("" . a:args)
	end
endfunction

function! RunTest(args)
  if @% =~ "\.feature$"
    call RunCucumber(":" . line('.') . a:args)
  elseif @% =~ "\_spec.rb$"
    call RunSpec("-l " . line('.') . a:args)
  end
endfunction

function! RunNose(args)
  let cmd = 'tox'
  execute ":!" .cmd . " &&"
endfunction

map <Leader>; :call RunTest("")<CR>
map <Leader>' :call RunTestFile("")<CR>
map <Leader>n :call RunNose("")<CR>

" Removes trailing spaces
function! TrimWhiteSpace()
     %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"always show filename at the bottom of the terminal
set modeline
set ls=2

" enable python module plugin
let g:pymode = 1
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_options_max_line_length = 90

" remove big red line that shows line length border
autocmd BufRead *.py setlocal colorcolumn=0

" don't prompt when saving session to do an session autosave
" let g:session_autosave = 'yes'
" let g:session_autoload = 1
" let g:session_directory = getcwd()
" let g:session_autosave_periodic = 10

"let g:syntastic_python_checkers = ['pylint']
"let g:pymode_doc = 0

set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=80

map <tab> <c-w>
map <tab><tab> <c-w><c-w>

" indent xml files like html files..etc...using gg=G
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
"Map tab to autocomplete option
":imap <tab> <c-x><c-o>

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

let NERDTreeIgnore = ['\.pyc$']

let g:mocha_coffee_command = "!node_modules/mocha/bin/mocha --require coffee-script/register --compilers coffee:coffee-script/register  --require co-mocha {spec}"
map <Leader>m :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
