if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
export PATH=/usr/local/bin:$PATH
eval "$(rbenv init -)"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
