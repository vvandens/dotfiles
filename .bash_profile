export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)

export ANT_OPTS="-Xmx1G -XX:MaxPermSize=128m"
export ANT_HOME=/opt/local/share/java/apache-ant
export MAVEN_OPTS="-Xmx2G -XX:MaxPermSize=256m"
export M2_REPO=/Users/vvandens/.m2/repository
export M2_HOME=/opt/local/share/java/maven32
export GIT_HOME=/usr/local/git

# MacPorts Bash shell command completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export http_proxy=`proxy-config -h`
export https_proxy=`proxy-config -s`
export ftp_proxy=`proxy-config -f`

# MacPorts Installer addition on 2011-07-22_at_17:06:35: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# MySQL Path
export PATH=/usr/local/mysql/bin:$PATH
# End MySQL Path

# Oracle Path
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Applications/envdev/instantclient_11_2
export SQLPATH=/Applications/envdev/instantclient_11_2
export ORACLE_HOME=$SQLPATH
export PATH=$SQLPATH:$PATH
# End Oracle Path

# Git path
export PATH=$GIT_HOME/bin:$PATH
source $GIT_HOME/contrib/completion/git-completion.bash
# End Git path

# ActivePivot license
export ACTIVEPIVOT_LICENSE=/Users/vvandens/Documents/Business/Partenaires/QuartetFS/ActivePivot.lic.7380

# Setenv from launchd.conf
grep -E "^setenv" /etc/launchd.conf | xargs -t -L 1 launchctl > /dev/null 2>&1


# MacPorts Installer addition on 2014-10-23_at_03:27:24: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
