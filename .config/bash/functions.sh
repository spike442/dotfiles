backup() {
  [[ $# -eq 1 ]] || { echo "usage: backup FILE" >&2; return 2; }
  cp -- "$1" "$1.bak"
}

copy() {
  if [[ $# -eq 2 && -d "$1" ]]; then
    command cp -r -- "${1%/}" "$2"
  else
    command cp "$@"
  fi
}

mkcd() {
  [[ $# -gt 0 ]] || { echo "usage: mkcd DIRECTORY" >&2; return 2; }
  mkdir -p -- "$@" && cd -- "$1"
}

yy() {
  command -v yazi >/dev/null 2>&1 || { echo "yazi is not installed" >&2; return 1; }
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return 1
  yazi "$@" --cwd-file="$tmp"
  if [[ -s "$tmp" ]]; then
    IFS= read -r cwd < "$tmp"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

commit() {
  local type scope description breaking message
  if [[ $# -eq 0 ]]; then
    echo "usage: commit TYPE [SCOPE] DESCRIPTION" >&2
    return 2
  fi

  type="$1"
  shift
  breaking=""

  if [[ "$type" == *'!^' ]]; then
    type="${type%!^}"
    breaking="!"
  elif [[ "$type" == *'^' ]]; then
    type="${type%^}"
  elif [[ "$type" == *'!' ]]; then
    type="${type%!}"
    breaking="!"
  fi

  if [[ "$1" != "" && "$type" != "fix" && "$type" != "feat" && "$type" != "chore" && $# -gt 1 ]]; then
    scope="$1"
    shift
    message="$type($scope)$breaking: $*"
  else
    message="$type$breaking: $*"
  fi

  git commit -s -m "$message"
}

ci() {
  git add --all && git commit --amend --no-edit && git push --force origin main
}
