# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
# for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
# shopt -s histappend;

# Autocorrect typos in path names when using `cd`
# shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# for option in autocd globstar; do
# 	shopt -s "$option" 2> /dev/null;
# done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
# if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
# 	complete -o default -o nospace -F _git g;
# fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
# complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
# complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Official git prompt for Bash
#
config_git_prompt () {
	source ~/.git-prompt.sh

	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_UNTRACKEDFILES=true
	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_HIDE_IF_PWD_IGNORED=true

	# # available only when using __git_ps1 for PROMPT_COMMAND or precmd
	# PROMPT_COMMAND="__git_ps1 '\u@\h:\w' '\\$ '"
	# GIT_PS1_SHOWCOLORHINTS=true

	# # Version 1: one color
	# PS1='\n\u@\h \w$(__git_ps1 " (%s)")\n\$ '

	# Version 2: colorful
	PS1="\[${bold}\]\n"; # newline
	PS1+="\[${red}\]\u"; # username
	PS1+="\[${white}\]@";
	PS1+="\[${red}\]\h "; # host
	PS1+="\[${green}\]\w "; # working directory full path
	PS1+="\$(__git_ps1 \"\[${blue}\](%s)\")"; # Git repository details
	PS1+="\n";
	PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
	export PS1;
}

if [ -f ~/.git-prompt.sh ]; then
	config_git_prompt
else
	wget -qO ~/.git-prompt.sh \
		https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
		&& config_git_prompt
fi

# Kubectl Autocomplete
if [[ -x "$(command -v kubectl)" ]]; then
	source <(kubectl completion bash)
fi

