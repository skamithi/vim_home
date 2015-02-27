runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
set number
set hls
set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=80
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
"  execute ":Rvm use" "
  return  a:name
endfunction

function! RunSpec(args)
	let spec = RailsScriptIfExists("zeus test --color -f d")
	let cmd = spec . " " . a:args . " " . @%
  execute ":! echo " . cmd . " && " . cmd
endfunction

function! RunCucumber(args)
	let cucumber = RailsScriptIfExists("zeus cucumber")
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

function! RunCakeFile(args)
	let cmd = "cake test"
  execute ":! echo " . cmd . " && " . cmd
endfunction

map <Leader>; :call RunTest("")<CR>
map <Leader>' :call RunTestFile("")<CR>
map <Leader>c :call RunCakeFile("")<CR>
" Removes trailing spaces
function! TrimWhiteSpace()
 " don't strip on these filetypes
    if &ft =~ 'modula2\|markdown'
        return
    endif
    %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"Save coffeescript files as JS files automatically using the save option
"autocmd BufWritePost,FileWritePost *.coffee silent !make


"always show filename at the bottom of the terminal
set modeline
set ls=2

set tags+=./tags
map <leader>, :!ctags -R --exclude=.git --exclude=logs --exclude=doc .<CR>

au BufRead,BufNewFile *.rb setlocal tags+=~/.vim/tags/ruby_and_gems
