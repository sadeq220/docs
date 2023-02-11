## bash EXPANSION(7s)
- parameter expansion ` ${variable} $var `
- command substitution `` $(command) `command` ``
- tilde expansion ` ~name `
- arithmetic expansion ` $((arithemtic expression)) `
- brace expansion ` {a1,a2} {I1..I2} ` **arg increasing*
- pathname expansion(globbing) ` [chars] * ? ` **arg increasing*
- word splitting(IFS) **arg increasing*

> use " " to prevent *arg increasing*    
## less tricks
to set mark 'a' : ma   
to goto mark 'a' : 'a
## bypass alias
- use built-in command  *command*  ` e.g. command ls `
- use leading \\ ` e.g. \ls `   
<p>
<img src="screenShot-bypassAlias.png" width="50%" height="300" />
</p>
## bash directory stack   
The directory stack is a list of recently-visited directories. The ` pushd ` builtin adds directories to the stack as it changes the current directory, and the ` popd ` builtin removes specified directories from the stack and changes the current directory to the directory removed. The ` dirs ` builtin displays the contents of the directory stack. The current directory is always the "top" of the directory stack.    
```
dirs -v #to show directory stack with indices
pushd <dir> #to push cwd to directory stack and also change cwd to 'dir'
cd ~<N> # where <N> is directory stack index , to use directory stack index and tilde expansion to change cwd
pushd # push cwd to directory stack and change cwd to ~1
```

