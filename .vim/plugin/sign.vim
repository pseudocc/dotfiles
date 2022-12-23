" Insert your name and email address (git/debian)
"
" Author: Atlas Yu <atlas.yu@canonical.com>
" Version: 0.1.0
" License: MIT
" Repository: https://github.com/pseudocc/vim-sign

if exists('g:vimsign_is_ready') || &cp
  if g:vim_sign_is_ready
    finish
  endif
endif

let g:vim_sign_is_ready = 1

func! VimSignGetDebName()
  let name = system('echo $DEBFULLNAME')
  return name
endf

func! VimSignGetDebEmail()
  let email = system('echo $DEBEMAIL')
  return email
endf

func! VimSignGetGitName()
  let name = system('git config user.name')
  return name
endf

func! VimSignGetGitEmail()
  let email = system('git config user.email')
  return email
endf

func! VimSign(is_git)
  if a:is_git
    let name = VimSignGetGitName()
    let email = VimSignGetGitEmail()
  else
    let name = VimSignGetDebName()
    let email = VimSignGetDebEmail()
  endif
  return trim(name)." <".trim(email).">"
endf

inoremap <expr> <C-s>d VimSign(0)
inoremap <expr> <C-s>g VimSign(1)