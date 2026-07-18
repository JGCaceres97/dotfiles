#!/usr/bin/env bash

set -euo pipefail

ROOT="$HOME"
MAP="$ROOT/setup/mappings/linux.map"

confirm_replace() {
  local dst="$1"

  if [[ ! -e "$dst" && ! -L "$dst" ]]; then
    return 0
  fi

  read -rp "'$dst' ya existe. ¿Reemplazar? [y/N] " answer <&3

  case "$answer" in
    y|Y|yes|YES)
      rm -rf "$dst"
      return 0
      ;;
    *)
      echo "⏭️  Omitido."
      return 1
      ;;
  esac
}

while IFS= read -r line; do

  [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

  read -r action source _ destination <<< "$line"

  src="$ROOT/$source"
  dst="${destination/#\~/$HOME}"
  dst="$(eval echo "$dst")"

  mkdir -p "$(dirname "$dst")"

  case "$action" in

    link)

      if [[ -L "$dst" ]]; then
        current="$(readlink "$dst")"

        if [[ "$current" == "$src" ]]; then
          echo "✓ Ya enlazado: $dst"
          continue
        fi
      fi

      if confirm_replace "$dst"; then
        ln -s "$src" "$dst"
        echo "🔗 Enlazado: $dst"
      fi
      ;;

    copy)

      if confirm_replace "$dst"; then
        cp "$src" "$dst"
        echo "📄 Copiado: $dst"
      fi
      ;;

    *)

      echo "Acción desconocida: $action"
      ;;

  esac

done < "$MAP" 3</dev/tty

echo
echo "Instalación finalizada."
