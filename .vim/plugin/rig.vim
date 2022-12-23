" Insert random identifier for you codes
" A great plugin to make codes unmaintainable
" 
" Author:       Yu Ze <pseudoc@163.com>
" Version:      0.2.0
" License:      MIT
" Repository:   https://github.com/pseudoc/rig

if exists('g:rig_is_ready') || &cp
  if g:rig_is_ready
    finish
  endif
endif

let g:rig_version = 0
let g:rig_memory = {}
let g:rig_lifetime = 1024
let g:rig_is_ready = 1
let g:rig_fixed_size = 3

" Pattern for generation
" u - upper case
" l - lower case
" d - digit
" x - blank
let g:rig_patterns = ['l', 'lldux', 'lddx']
let g:rig_fixed_patterns = ['l', 'lldu', 'ldu']
let g:rig_patconf = {
  \'l': [97, 26],
  \'u': [65, 26],
  \'d': [48, 10],
  \'x': [0, 1]
  \}

func! Rand()
  let i15 = system('echo $RANDOM')
  let i15 = str2nr(i15)
  return i15
endf

func! RigForget()
  let g:rig_version = 0
  let g:rig_memory = {}
  return ''
endf

func! RigOne(pt)
  let offset = g:rig_patconf[a:pt][0]
  let size = g:rig_patconf[a:pt][1]
  let rn = Rand() % size 
  return nr2char(rn + offset)
endf

func! RigCore(pts, n)
  let id = ''
  let i = 0
  let size = len(a:pts)

  while i < a:n
    if i < size
      let pt = a:pts[i]
    else
      let rn = Rand() % (size - 1) + 1
      let pt = a:pts[rn]
    endif
    let lp = strlen(pt)
    let rn = Rand() % lp
    let p1 = nr2char(strgetchar(pt, rn))
    let id = id.RigOne(p1)
    let i = i + 1
  endwhile

  return id
endf

func! RigGenerate(fixed) abort
  try
    if a:fixed
      if a:fixed < 0
        let n = getchar() - 48
        if n < 0 || n > 9
          echoerr "Not a number"
          return ''
        endif
      else
        let n = a:fixed
      endif
      let pts = g:rig_fixed_patterns
    else
      let n = len(g:rig_patterns)
      let pts = g:rig_patterns
    endif
    let rig = RigCore(pts, n)
  catch
    let g:rig_is_ready = 0
    echoerr v:exception
  endtry

  if get(g:rig_memory, rig, -1) < 0 ||
    \g:rig_memory[rig] < g:rig_version - g:rig_lifetime
    let g:rig_version = g:rig_version + 1
    let g:rig_memory[rig] = g:rig_version
    return rig
  endif
  return RigGenerate(0)
endf

inoremap <expr> <C-z>i RigGenerate(-1)
inoremap <expr> <C-z>z RigGenerate(0)
inoremap <expr> <C-z>x RigGenerate(g:rig_fixed_size)
inoremap <expr> <C-z>c RigForget() 

