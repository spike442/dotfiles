#!/usr/bin/env bash
set -Eeuo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
aqua_root="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}"

"$repo_dir/sync.sh"

if [[ ! -x "$aqua_root/bin/aqua" ]]; then
  curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.5/aqua-installer | sh -s -- -y
fi

export AQUA_ROOT_DIR="$aqua_root"
export PATH="$AQUA_ROOT_DIR/bin:$PATH"
aqua --config "$repo_dir/aqua.yaml" install

echo "Dotfiles and Aqua tools installed."
