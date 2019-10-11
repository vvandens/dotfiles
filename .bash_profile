export BASH_SILENCE_DEPRECATION_WARNING=1

export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)

export ANT_OPTS="-Xmx1G -XX:MaxPermSize=128m"
export MAVEN_OPTS="-Xmx2G -XX:MaxPermSize=256m -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2"
export M2_REPO=/Users/vvandens/.m2/repository

export ANDROID_HOME=/usr/local/opt/android-sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools:$PATH

# Cordova bash shell command completion
if [ -f /usr/local/lib/node_modules/cordova/scripts/cordova.completion ]; then
  . /usr/local/lib/node_modules/cordova/scripts/cordova.completion
fi

# Brew bash shell command completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export http_proxy=`networksetup -getwebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print "http://"l2":"l3}' | head -n 1`
export https_proxy=`networksetup -getsecurewebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print "http://"l2":"l3}' | head -n 1`
export ftp_proxy=`networksetup -getftpproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print "http://"l2":"l3}' | head -n 1`
export http_proxy_host=`networksetup -getwebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l2}' | head -n 1`
export http_proxy_port=`networksetup -getwebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l3}' | head -n 1`
export https_proxy_host=`networksetup -getsecurewebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l2}' | head -n 1`
export https_proxy_port=`networksetup -getsecurewebproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l3}' | head -n 1`
export ftp_proxy_host=`networksetup -getftpproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l2}' | head -n 1`
export ftp_proxy_port=`networksetup -getftpproxy Wi-Fi | awk {'print $2'} | awk '$1=="Yes" {getline l2; getline l3; print l3}' | head -n 1`

export HTTP_PROXY=${http_proxy}
export HTTPS_PROXY=${https_proxy}
export FTP_PROXY=${ftp_proxy}
export HTTP_PROXY_HOST=${http_proxy_host}
export HTTP_PROXY_PORT=${http_proxy_port}
export HTTPS_PROXY_HOST=${https_proxy_host}
export HTTPS_PROXY_PORT=${https_proxy_port}
export FTP_PROXY_HOST=${ftp_proxy_host}
export FTP_PROXY_PORT=${ftp_proxy_port}

# MySQL Path
export PATH=/usr/local/mysql/bin:$PATH
# End MySQL Path

# Oracle Path
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Applications/envdev/instantclient_11_2
export SQLPATH=/Applications/envdev/instantclient_11_2
export ORACLE_HOME=$SQLPATH
export PATH=$SQLPATH:$PATH
# End Oracle Path

# Liqibase
export LIQUIBASE_HOME=/Applications/envdev/liquibase
export PATH=$LIQUIBASE_HOME:$PATH

# NodeJS v10 pin
export PATH="/usr/local/opt/node@10/bin:$PATH"

# ActivePivot license
export ACTIVEPIVOT_LICENSE=/Users/vvandens/Documents/Business/Partenaires/QuartetFS/ActivePivot.lic.7380

# Setenv from launchd.conf
grep -E "^setenv" /etc/launchd.conf | xargs -t -L 1 launchctl > /dev/null 2>&1

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
	# export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
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

# Link pinentry and gpg agent together so that gpg does not ask passphrase for every signed commmit
# useless as of gpg 2.1+
#if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
#  source ~/.gnupg/.gpg-agent-info
#  export GPG_AGENT_INFO
#else
#  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
#fi

#if [ -z "$HTTP_PROXY" ]; then
#  npm config delete proxy
#  npm config delete http-proxy
#  npm config delete https-proxy
#else
#  npm config set proxy $HTTP_PROXY
#  npm config set http-proxy $HTTP_PROXY
#  npm config set https-proxy $HTTPS_PROXY
#fi
