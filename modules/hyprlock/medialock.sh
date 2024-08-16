#! /usr/bin/env bash

# shellcheck disable=SC1090
source ~/.config/hypr/scripts/rsum.sh

function media-art-cache {
  local last=""
  local medI=""
  while [ -f "${MEDIA_ART_CACHE_LOC}" ]; do
    if medI="$(playerctl metadata mpris:artUrl 2> /dev/null)"; then
      if [ "${last}" != "${medI}" ]; then
        cat "${medI:7}" > "${MEDIA_ART_CACHE_LOC}"
        last="${medI}"
        # Send Hyprlock signal to reload image
        if pgrep -x 'hyprlock' &>/dev/null; then
          pkill -SIGUSR2 hyprlock
        fi
      fi
    fi
    sleep 0.5
  done
}

function media-metadata-get {
  local what="${1}"
  local METAINFO="none"
  case "${what}" in
    'title' | 'artist' | 'album' | 'playerName')
      read -r METAINFO < <(playerctl -f "{{${what}}}" metadata)
      if ((${#METAINFO} > 25)); then
        METAINFO="${METAINFO:0:24}…"
      fi
      printf '%s' "${METAINFO}"
      ;;
    'duration'*)
      read -r METAINFO < <(playerctl -f "{{mpris:length}}" metadata)
      METAINFO="$((METAINFO / 1000000))" # Now it's in seconds

      if [[ "${what}" == *"sec" ]]; then
        printf '%d' "${METAINFO}"
      else
        local MINS="$((METAINFO / 60))"
        local SECS="$((METAINFO % 60))"
        printf '%d:%02d' "${MINS}" "${SECS}"
      fi
      ;;
    'elapsed'*)
      read -r METAINFO < <(playerctl position)
      METAINFO="${METAINFO%%.*}" # Now it's only seconds
      if [[ "${what}" == *"sec" ]]; then
        printf '%d' "${METAINFO}"
      else
        local MINS="$((METAINFO / 60))"
        local SECS="$((METAINFO % 60))"
        printf '%d:%02d' "${MINS}" "${SECS}"
      fi
      ;;
    'progress'*)
      read -r METAINFO < <(playerctl -f "{{mpris:length}}" metadata)
      TOTAL="$((METAINFO / 1000000))" # Now it's in seconds
      read -r METAINFO < <(playerctl position)
      ELAPSED="$(((${METAINFO%%.*} * 100) / TOTAL))"

      if [[ "${what}" == *"bar" ]]; then
        ELAPSED="$((ELAPSED/3))"
        local ELAPSEDR="$((33 - ELAPSED))"
        printf "%${ELAPSED}s" | tr ' ' '-' | printf -- "$(cat -)%${ELAPSEDR}s"
      else
        printf '%s' "${ELAPSED}"
      fi
      ;;
    'status'*)
      read -r METAINFO < <(playerctl status)
      if [[ "${what}" == *"icon" ]]; then
        # Icon is the action to be made, not the status, except stop
        printf '%s' "${states[${METAINFO,,}]}"
      else
        printf '%s' "${METAINFO,,}"
      fi
  esac
}

function hyprlock-mw-source-manager {
  local csrc_str='^# source = ~/\.config/hypr/conf\.d/medialock\.conf$'
  local usrc_str='^source = ~/\.config/hypr/conf\.d/medialock\.conf$'
  while true; do
    read -r media_session_status < <(playerctl status)
    if [ "${media_session_status}" != "Stopped" ] && grep -qP "${csrc_str}" ~/.config/hypr/hyprlock.conf; then
      # Uncomment source, reload
      sed -i '/^#__medialock__/{n; s/^# //; }' ~/.config/hypr/hyprlock.conf
      pgrep -x 'hyprlock' &>/dev/null && pkill -SIGUSR2 hyprlock
    elif [ "${media_session_status}" == "Stopped" ] && grep -qP "${usrc_str}" ~/.config/hypr/hyprlock.conf; then
      # Comment source, reload
      sed -i '/^#__medialock__/{n; s/^\([^#]\)/# \1/; }' ~/.config/hypr/hyprlock.conf
      pgrep -x 'hyprlock' &>/dev/null && pkill -SIGUSR2 hyprlock
    fi
    sleep 1
  done
}

function main {
  local what="${1:?Need something do: \{hwman,artup,artdown,title,artist,album,player,elapsed\}}"
  shift 1

  # Icon is the action to be made, not the status, except stop
  declare -A states=(
    ['playing']=""
    ['paused']=""
    ['stopped']=""
  )
  MEDIA_ART_CACHE_LOC=~/.cache/hyprland/medialock.cache

  if [ "${what}" == "artup" ]; then
    test -f "${MEDIA_ART_CACHE_LOC}" && rm "${MEDIA_ART_CACHE_LOC}" 2> /dev/null
    touch "${MEDIA_ART_CACHE_LOC}"
    media-art-cache &>/dev/null &
    return
  elif [ "${what}" == "artup" ]; then
    test -f "${MEDIA_ART_CACHE_LOC}" && rm "${MEDIA_ART_CACHE_LOC}" 2> /dev/null
    return
  elif [ "${what}" == "hwman" ]; then
    hyprlock-mw-source-manager &>/dev/null &
    return
  fi

  local format_it='\{\{([a-z_]+)\}\}'
  while [[ "${what}" =~ ${format_it} ]]; do
    IFS=$'\n' read -r res < <(media-metadata-get "${BASH_REMATCH[1]}")
    what="${what//"${BASH_REMATCH[0]}"/"${res}"}"
  done

  printf '%s' "${what}"
}

main "${@}"
