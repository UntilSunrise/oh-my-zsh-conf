# Copy and self modified from ys.zsh-theme, the one of default themes in master repository
# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
# 15 Feb 2016 - Jens

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1="%{$fg_bold[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg_bold[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}%{$FX[bold]%} "
YS_VCS_PROMPT_DIRTY=" %{$fg_bold[red]%}✗"
YS_VCS_PROMPT_CLEAN=" %{$fg_bold[green]%}✔︎"

# Git info.
local git_info='$(git_prompt_info)'
local git_last_commit='$(git log --pretty=format:"%h \"%s\"" -1 2> /dev/null)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}%{$FX[bold]%}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}


local BLUE="%{$FG[033]%}"
local LIGHTBLUE="%{$FG[081]%}"
local GREY="%{$FG[242]%}"
local PURPLE="%{$FG[161]%}"
local RED="%{$FG[196]%}"
local YELLOW="%{$FG[214]%}"

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $ 
PROMPT="\
%{$FX[bold]%}\
${RED}%* \
${GREY}[\
${YELLOW}%n\
${GREY}@\
${PURPLE}$(box_name)\
${GREY}:\
${BLUE}${current_dir}\
${GREY}] \
%{$reset_color%}\
${hg_info} \
${git_info} \
${git_last_commit}
%{$FX[bold]%}\
$fg_bold[white]%}› %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="\
%{$FX[bold]%}\
${RED}%* \
${GREY}[\
%{$BG[196]%}${YELLOW}%n%{$reset_color%}%{$FX[bold]%}\
${GREY}@\
${PURPLE}$(box_name)\
${GREY}:\
${BLUE}${current_dir}\
${GREY}] \
%{$reset_color%}\
${hg_info} \
${git_info} \
${git_last_commit}
%{$FX[bold]%}\
${RED}$ \
%{$reset_color%}"
fi
