#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <package-name>"
    exit 1
fi

PKG="$1"
CACHE="/var/cache/pacman/pkg"

echo "Searching cached versions for: $PKG"
echo

mapfile -t PKGS < <(printf '%s\n' "$CACHE"/"$PKG"-*.pkg.tar.zst 2>/dev/null | sort -Vr)

if [ ${#PKGS[@]} -eq 0 ]; then
    echo "No cached versions found for $PKG"
    exit 1
fi

echo "Available versions:"
for i in "${!PKGS[@]}"; do
    printf "%d) %s\n" "$((i+1))" "$(basename "${PKGS[$i]}")"
done

echo
read -rp "Select version number: " NUM

if ! [[ "$NUM" =~ ^[0-9]+$ ]] || [ "$NUM" -lt 1 ] || [ "$NUM" -gt "${#PKGS[@]}" ]; then
    echo "Invalid selection"
    exit 1
fi

FILE="${PKGS[$((NUM-1))]}"

echo
echo "Installing: $FILE"
sudo pacman -U "$FILE"
