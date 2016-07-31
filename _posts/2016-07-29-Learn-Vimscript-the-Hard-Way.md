---
layout: post
title: "Learn Vimscript the Hard Way"

---


显示 vimrc 位置:

	:echo $MYVIMRC
	
显示信息：

	:echo "hello world"
	:echom "hello again, world"

`:message`打印的列表保存了`echom`的信息。

## 设置选项

boolean 选项：

	:set number
	:set nonumber
	:set number!		"toggle option
	:set number?		"check option

带值的选项：

	:set number
	:set numberwidth=10
	:set numberwidth=4
	:set number?

设置 buffer local 选项：
	
	:setlocal number
	:setlocal wrap

一些选项：

	wrap shiftaround matchtime

misc：
	
	:help 'number' "get help for option number
	:help number "get help for command number

## Mappings

basic mapping:

	:map char command
	:unmap char

special chars:

	<space> <c-d> <esc> <cr> <nop> <cword>
	
modal mapping:

	nmap   vmap   imap
	nunmap vunmap iunmap

Nonrecursive Mapping:

	noremap nnoremap vnoremap inoremap

leader char:

	:let mapleader = "-"
	:nnoremap <leader>d dd
	
same as:

	:nnoremap -d dd

local leader:

	"map to char `\`"
	:let maplocalleader = "\\" 

abbreviation:

	:iabbrev @@    steve@stevelosh.com
	:iabbrev <buffer> --- &mdash;
	
a sample mapping:

	:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

buffer-local mapping,takes effect only in current buffer:

	:nnoremap <buffer> <localleader>x dd

shadowing:

	"first command will override second if in local buffer
	:nnoremap <buffer> Q x
	:nnoremap 				 Q dd

## Autocommands

	:autocmd event[,event2...]  pattern command
	:autocmd BufNewFile *       :write
	
	"pattern: * *.txt *.py
	"command: cannot use special chars

FileType events:

	:autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
	:autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

get list of all events:

	:help autocmd-events

combine with buffer-local abbreviation:

	:autocmd FileType python     :iabbrev <buffer> iff if:<left>
	:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

autocmd groups:

	"group autocmd, trigger when event happens
	:augroup testgroup
	:    autocmd BufWrite * :echom "Foo"
	:    autocmd BufWrite * :echom "Bar"
	:augroup END
	
	:augroup testgroup
	:    autocmd BufWrite * :echom "Baz"
	:augroup END

clearing groups:

	:augroup testgroup
	:    autocmd!
	:    autocmd BufWrite * :echom "Cats"
	:augroup END

movement mappings:

	:onoremap p i(
	:onoremap b /return<cr>
	:onoremap in( :<c-u>normal! f(vi(<cr>

execute:

	:execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"
	"\\: '\'
	"\r: <cr>
	"normal: <esc>
	
## status lines

	:set statusline=%f\ -\ FileType:\ %y
	:set statusline=[%4l]
	:help statusline
	
## variables
	"read and write a variable
	:let foo = "bar"
	:echo foo
	
	"set and echo an option
	:set textwidth=80
	:echo &textwidth
	
	"set local option
	:let &l:number = 1
	
	"assgin a register
	:let @a = "hello!"
	:echo @a
	
	"local buffer variable
	:let b:hello = "world"
	:echo b:hello

## conditions

 	:if "condition"
	:    do something
	:endif
	
	"9024" = 9024
	"hello" + 10 = 10
	"10hello" + 10 = 20
	"hello10" + 10 = 10
	
	:if 0
	:    echom "if"
	:elseif "nope!"
	:    echom "elseif"
	:else
	:    echom "finally!"
	:endif

Comparison:

	> < == 
	==? case-insensitive
	==# case-sensitive

## functions

	:function Meow()
	:  echom "Meow!"
	:endfunction " 隐式返回 0
	:call Meow()

	:function GetMeow()
	:  return "Meow String!"
	:endfunction
	:echom GetMeow()
	
arguments:

	:function DisplayName(name)
	:  echom "Hello!  My name is:"
	:  echom a:name
	:endfunction
	:call DisplayName("Your Name")

varargs:

	:function Varg(...)
	:  echom a:0
	:  echom a:1
	:  echo a:000
	:endfunction
	
	:call Varg("a", "b")
	
not allowed to assign a argument:

	:function Assign(foo)
	:  let a:foo = "Nope"
	:  echom a:foo
	:endfunction
	
	:call Assign("test")

should like:

	:function AssignGood(foo)
	:  let foo_tmp = a:foo
	:  let foo_tmp = "Yep"
	:  echom foo_tmp
	:endfunction
	
	:call AssignGood("test")
	
## variable types

numbers:

	100 0xff 010 100.1 5.23e+3 15.3e9

Coercion:

	2 * 2.0 = 4.0
	3/2 = 1
	3/2.0 = 1.5

strings:
	
	"hello," + "world" = 0
	"3 mice" + "2 cats" = 5
	10 + "10.10" = 20
	"hello, " . "world" = "hello, world"
	10 . "foo" = "10foo"
	10.1 . "foo" = error

special chars:

	\" \\ \n 

literal string:

	'\n\\'
	'That''s enough.' = "That's enough."
help:

	:help expr-quote
	:help literal-string

string functions:

	strlen() len()
	split(s,sep=' ')
	
	:echo join(["foo", "bar"], "...") = foo...bar
	
	tolower() toupper()
	
## execute and normal

execute:

	:execute "echom 'Hello, world!'"

normal:

	:normal G
	:normal ggdd
	
	"run a command without recursive mapping
	:nnoremap G dd
	:normal! G		"go to last lline
	
combine together:

	" `\<cr>` simulates ESC key in insert mode
	:execute "normal! gg/foo\<cr>dd"
		
# regular expressions

helps:

	:help magic
	:help pattern-overview

# lists

	:echo ['foo', [3, 'bar']]
	:echo [0, [1, 2]][1]
	:echo [0, [1, 2]][-2]
	:echo ['a', 'b', 'c', 'd', 'e'][0:2]
	:echo ['a', 'b', 'c', 'd', 'e'][0:100000]
	
	['a', 'b'] + ['c'] = ['a', 'b', 'c']

functions:
	
	add(['a'], 'b') = ['a', 'b']
	
	len(list) get() index() join() reverse()
	
## loops

for:

	:for i in list
	:    do something
	:endfor
	
while:

	:let c = 1
	:let total = 0
	
	:while c <= 4
	:  let total += c
	:  let c += 1
	:endwhile
	
	:echom total

## dictionaries

	:echo {'a': 1, 100: 'foo'}

indexing:

	:echo {'a': 1, 100: 'foo',}['a']
	:echo {'a': 1, 100: 'foo',}[100]
	
	:echo {'a': 1, 100: 'foo',}.a
	:echo {'a': 1, 100: 'foo',}.100

assigning and adding:

	:let foo = {'a': 1}
	:let foo.a = 100
	:let foo.b = 200
	:echo foo

removing entries:

	:let test = remove(foo, 'a')
	:unlet foo.b
	:echo foo
	:echo test
	
functions:

	get() has_key() items()
	
## paths

	%: the current file
	%:p: absolute path
	
listing files:

	:echo globpath('.', '*')
