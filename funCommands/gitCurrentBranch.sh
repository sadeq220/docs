#!/bin/bash
# use this function for "PS1" shell variable like bellow
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[38;5;192m\]$(parse_git_branch)\[\033[00m\]\$ '
parse_git_branch () {
 local main_part=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/^\*[[:space:]]//1' )
 echo "${main_part:+($main_part)}"
}
