#!/usr/bin/env bash
set -Eeuo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_source="$repo_dir/.config"
home_config="$HOME/.config"
backup_root="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

[[ -d "$config_source" ]] || { echo "Missing $config_source" >&2; exit 1; }

backup_target() {
  local target="$1"
  local relative="${target#"$HOME"/}"
  local backup="$backup_root/$relative"

  [[ -e "$target" || -L "$target" ]] || return 0
  mkdir -p -- "$(dirname -- "$backup")"
  mv -- "$target" "$backup"
  echo "Backed up $target -> $backup"
}

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p -- "$(dirname -- "$target")"
  if [[ -L "$target" && "$(readlink -- "$target")" == "$source" ]]; then
    return 0
  fi
  backup_target "$target"
  ln -s -- "$source" "$target"
  echo "Linked $target -> $source"
}

while IFS= read -r -d '' source; do
  relative="${source#"$config_source"/}"
  link_file "$source" "$home_config/$relative"
done < <(find "$config_source" -type f -print0)

link_file "$repo_dir/.bashrc" "$HOME/.bashrc"

# Remove the legacy local tmux configuration after backing it up.
if [[ -e "$home_config/tmux" || -L "$home_config/tmux" ]]; then
  backup_target "$home_config/tmux"
  echo "Removed legacy tmux configuration; backup is under $backup_root"
fi

if [[ -d "$backup_root" ]]; then
  echo "Backups created at: $backup_root"
fi
echo "Bash dotfiles synchronized successfully."
