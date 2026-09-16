#!/bin/bash

# Check that every package the installers request from the Ubuntu archive can be installed.
# Run as root in a clean Ubuntu container after apt-get update, e.g. ubuntu:24.04 or ubuntu:26.04.
# Installers that add their own apt repository are skipped, since that repository only exists at install time.
# A missing package is accepted when its installer checks for it with "apt-cache show <package>" first.

set -euo pipefail
cd "$(dirname "$0")/.."

requests=()
skipped=0

for installer in $(git ls-files 'install/*.sh' 2>/dev/null || find install -name '*.sh' | sort); do
  if grep -qE 'add-apt-repository|sources\.list\.d' "$installer"; then
    skipped=$((skipped + 1))
    continue
  fi

  # Join continued lines, then keep only the arguments of each apt install command
  while read -r args; do
    [[ " $args " == *" -s "* ]] && continue # apt-get install -s only simulates

    for word in $args; do
      case $word in
      -* | ./* | *.deb | \$*) continue ;;
      *{*) for expanded in $(eval "echo $word"); do requests+=("$installer $expanded"); done ;;
      *) requests+=("$installer $word") ;;
      esac
    done
  done < <(sed -e ':a' -e '/\\$/N; s/\\\n//; ta' "$installer" |
    grep -oE 'apt(-get)? (-y )?install [^&|;>]*' |
    sed -E 's/^apt(-get)? (-y )?install //')
done

. /etc/os-release
echo "Ubuntu $VERSION_ID: checking ${#requests[@]} package requests, skipping $skipped installers with their own repository"

failed=()
for request in "${requests[@]}"; do
  installer=${request% *}
  package=${request#* }

  if ! apt-get install -s -y "$package" >/dev/null 2>&1; then
    if grep -q "apt-cache show $package" "$installer"; then
      echo "Not available, handled by $installer: $package"
    else
      failed+=("$package ($installer)")
    fi
  fi
done

if ((${#failed[@]})); then
  printf 'Not installable on Ubuntu %s:\n' "$VERSION_ID"
  printf '  %s\n' "${failed[@]}"
  exit 1
fi

echo "All packages are installable"
