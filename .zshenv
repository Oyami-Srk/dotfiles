export SSH_KEY_PATH="~/.ssh/id_rsa"
export PATH="/Users/shiroko/node_modules/tern/bin/:$PATH"
export CLASSPATH=".:/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH"
# export PYTHONSTARTUP=/usr/lib/python2.7/dist-packages/tab.py

alias emacs='emacsclient -a "" -c'
alias e=emacs
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java org.antlr.v4.gui.TestRig'
alias s=screen
alias sl='screen -ls'
alias sr='screen -r'
