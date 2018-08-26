# The prompt
PROMPT='$(_user_host)$(_python_venv)%{$fg[cyan]%}%c $(git_prompt_info)%{$reset_color%}${prompt_pure_git_arrows} $(_git_time_since_commit)$(git_prompt_status)${_return_status}➜ '

# Prompt with SHA
# PROMPT='$(_user_host)$(_python_venv)%{$fg[cyan]%}%c $(git_prompt_info)%{$reset_color%}$(git_prompt_short_sha)%{$fg[magenta]%}$(_git_time_since_commit)$(git_prompt_status)${_return_status}➜ '

local _return_status="%{$fg[red]%}%(?..⍉ )%{$reset_color%}"

function _user_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[cyan]%}$me%{$reset_color%}:"
  fi
}

# Determine if there is an active Python virtual environment
function _python_venv() {
  if [[ $VIRTUAL_ENV != "" ]]; then
    echo "%{$fg[blue]%}(${VIRTUAL_ENV##*/})%{$reset_color%} "
  fi
}

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{yellow}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "
ZSH_THEME_GIT_PROMPT_CLEAN=" "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✓ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}△ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%}▲ "
ZSH_THEME_GIT_DOWN_ARROW="%{%F{cyan}%}⇣ "
ZSH_THEME_GIT_UP_ARROW="%{%F{cyan}%}⇡ "

ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[white]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"

#
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d "
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m "
    else
      commit_age="${minutes}m "
    fi
    if [[ -n $(git status -s 2> /dev/null) ]]; then
        if [ "$hours" -gt 4 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
        elif [ "$minutes" -gt 30 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
        fi
    else
        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
    fi


    echo "$COLOR$commit_age%{$reset_color%}"
  fi
}

prompt_pure_precmd() {
  # check for git arrows
  prompt_pure_check_git_arrows

  # get vcs info
  vcs_info

  # preform async git dirty check and fetch
  prompt_pure_async_tasks
}

prompt_pure_preexec() {
  # attempt to detect and prevent prompt_pure_async_git_fetch from interfering with user initiated git or hub fetch
  [[ $2 =~ (git|hub)\ .*(pull|fetch) ]] && async_flush_jobs 'prompt_pure'
}

prompt_pure_async_tasks() {
  # initialize async worker
  ((!${prompt_pure_async_init:-0})) && {
    async_start_worker "prompt_pure" -u -n
    async_register_callback "prompt_pure" prompt_pure_async_callback
    prompt_pure_async_init=1
  }

  # store working_tree without the "x" prefix
  local working_tree="${vcs_info_msg_1_#x}"

  # check if the working tree changed (prompt_pure_current_working_tree is prefixed by "x")
  if [[ ${prompt_pure_current_working_tree#x} != $working_tree ]]; then
    # stop any running async jobs
    async_flush_jobs "prompt_pure"

    # reset git preprompt variables, switching working tree
    unset prompt_pure_git_dirty
    unset prompt_pure_git_last_dirty_check_timestamp

    # set the new working tree and prefix with "x" to prevent the creation of a named path by AUTO_NAME_DIRS
    prompt_pure_current_working_tree="x${working_tree}"
  fi

  # only perform tasks inside git working tree
  [[ -n $working_tree ]] || return

  # do not preform git fetch if it is disabled or working_tree == HOME
  if (( ${PURE_GIT_PULL:-1} )) && [[ $working_tree != $HOME ]]; then
    # tell worker to do a git fetch
    async_job "prompt_pure" prompt_pure_async_git_fetch "${working_tree}"
  fi

  # if dirty checking is sufficiently fast, tell worker to check it again, or wait for timeout
  integer time_since_last_dirty_check=$(( EPOCHSECONDS - ${prompt_pure_git_last_dirty_check_timestamp:-0} ))
  if (( time_since_last_dirty_check > ${PURE_GIT_DELAY_DIRTY_CHECK:-1800} )); then
    unset prompt_pure_git_last_dirty_check_timestamp
    # check check if there is anything to pull
    async_job "prompt_pure" prompt_pure_async_git_dirty "${PURE_GIT_UNTRACKED_DIRTY:-1}" "${working_tree}"
  fi
}

prompt_pure_async_callback() {
  local job=$1
  local output=$3
  local exec_time=$4

  case "${job}" in
    prompt_pure_async_git_dirty)
      prompt_pure_git_dirty=$output

      # When prompt_pure_git_last_dirty_check_timestamp is set, the git info is displayed in a different color.
      # To distinguish between a "fresh" and a "cached" result, the preprompt is rendered before setting this
      # variable. Thus, only upon next rendering of the preprompt will the result appear in a different color.
      (( $exec_time > 2 )) && prompt_pure_git_last_dirty_check_timestamp=$EPOCHSECONDS
      ;;
    prompt_pure_async_git_fetch)
      prompt_pure_check_git_arrows
      ;;
  esac
}

# fastest possible way to check if repo is dirty
prompt_pure_async_git_dirty() {
  local untracked_dirty=$1; shift

  # use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
  builtin cd -q "$*"

  if [[ "$untracked_dirty" == "0" ]]; then
    command git diff --no-ext-diff --quiet --exit-code
  else
    test -z "$(command git status --porcelain --ignore-submodules -unormal)"
  fi

  (( $? )) && echo "*"
}

prompt_pure_async_git_fetch() {
  # use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
  builtin cd -q "$*"

  # set GIT_TERMINAL_PROMPT=0 to disable auth prompting for git fetch (git 2.3+)
  GIT_TERMINAL_PROMPT=0 command git -c gc.auto=0 fetch
}

prompt_pure_check_git_arrows() {
  # reset git arrows
  prompt_pure_git_arrows=

  # check if there is an upstream configured for this branch
  command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

  local arrow_status
  # check git left and right arrow_status
  arrow_status="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"
  # exit if the command failed
  (( !$? )) || return

  # left and right are tab-separated, split on tab and store as array
  arrow_status=(${(ps:\t:)arrow_status})
  local arrows left=${arrow_status[1]} right=${arrow_status[2]}

  (( ${right:-0} > 0 )) && arrows+="${ZSH_THEME_GIT_DOWN_ARROW:-⇣}"
  (( ${left:-0} > 0 )) && arrows+="${ZSH_THEME_GIT_UP_ARROW:-⇡}"

  [[ -n $arrows ]] && prompt_pure_git_arrows="${arrows}"
}

prompt_pure_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info
  autoload -Uz async && async

  add-zsh-hook precmd prompt_pure_precmd
  add-zsh-hook preexec prompt_pure_preexec

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' use-simple true
  # only export two msg variables from vcs_info
  zstyle ':vcs_info:*' max-exports 2
  # vcs_info_msg_0_ = ' %b' (for branch)
  # vcs_info_msg_1_ = 'x%R' git top level (%R), x-prefix prevents creation of a named path (AUTO_NAME_DIRS)
  zstyle ':vcs_info:git*' formats ' %b' 'x%R'
  zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'
}

prompt_pure_setup "$@"
