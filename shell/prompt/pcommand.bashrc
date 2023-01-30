MAIN_COLOR="\[\033[38;5;88m\]";
SECONDARY_COLOR="\[\033[38;5;238m\]";
ACCENT_COLOR="\[\033[38;5;124m\]";
ACCENT2_COLOR="\[\033[38;5;242m\]";
TEXT_COLOR="\[\033[38;5;246m\]";

build_command(){
  GITINFO=""
  if gitstatus_query && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
    if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
    GITINFO+=" ${VCS_STATUS_LOCAL_BRANCH//\\/\\\\}"  # escape backslash
    else
    GITINFO+=" @${VCS_STATUS_COMMIT//\\/\\\\}"       # escape backslash
    fi
    (( VCS_STATUS_HAS_STAGED    )) && GITINFO+='+'
    (( VCS_STATUS_HAS_UNSTAGED  )) && GITINFO+='!'
    (( VCS_STATUS_HAS_UNTRACKED )) && GITINFO+='?'
  fi

  pwd2="$(pwd | sed -r 's#.*(/[^/]+)(/[^/]+)#...\1\2#g')"
#    gitbranch="$(git branch 2>/dev/null | grep '^*' | cut -c 2-)"
  FIRST_LINE="$ACCENT_COLOR$USERNAME$USER$ACCENT2_COLOR@$ACCENT_COLOR\h [ $ACCENT2_COLOR$pwd2 $MAIN_COLOR]$MAIN_COLOR$GITINFO$ACCENT_COLOR λ $TEXT_COLOR";
  retval="${FIRST_LINE}";
  PS1="$retval";
  shopt -u promptvars
}

PROMPT_COMMAND=build_command

