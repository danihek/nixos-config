#!/usr/bin/env bash

# Function to easy generate (random) strings
function rsum() {
  # Usage:
  # '-l' [LENGHT]     int
  # '-c' [CHAR]       string
  # '-s' [SEPARATOR]  string
  # '-t' [TIMES]      int
  # '-n' [Linebreak at end]
  # Example:
  #          rsum -l 16 -c '0-9' -s '-' -t 5 -n
  # Return: A string of 5 '16 number' strings separated by "-" and trailing linebreak
  # Default: 16 lenght alphanumeric string without trailing linebreak
  [ "${#}" -eq 0 ] && {
    tr -dc "a-zA-Z0-9" < /dev/urandom 2> >(sed 's/^tr:/rsum:/' >&2) | head -c "16"
    return
  }

  local LINEBREAK=false
  local LENGHT="16"
  local CHARS="a-zA-Z0-9"
  while [ "$#" -gt 0 ]; do
    case "${1}" in
      -l | -l*)
        if [ -n "${1#*-l}" ]; then
          LENGHT=${1#*-l}
          shift 1
        else
          LENGHT=${2}
          shift 2
        fi
        ;;
      -c)
        CHARS=${2}
        shift 2
        ;;
      -s)
        local SEPARATOR=${2}
        shift 2
        ;;
      -t | -t*)
        if [ -n "${1#*-t}" ]; then
          local TIMES=${1#*-t}
          shift 1
        else
          local TIMES=${2}
          shift 2
        fi
        ;;
      -n)
        LINEBREAK=true
        shift 1
        ;;
      *)
        shift 1
        ;;
    esac
  done

  [[ -n "${SEPARATOR}" && -n "${TIMES}" ]] && {
    [[ ${TIMES} =~ [0-9] ]] && {
      tr -dc "${CHARS}" < /dev/urandom 2> >(sed 's/^tr:/rsum:/' >&2) | head -c "$((LENGHT * TIMES))" | sed "s/\s//g;s/\(.\{1,${LENGHT}\}\)/\1${SEPARATOR}/g;s/${SEPARATOR}$//"
      ${LINEBREAK} && echo '' 2> /dev/null
      return
    }
  }

  tr -dc "${CHARS}" < /dev/urandom 2> >(sed 's/^tr:/rsum:/' >&2) | head -c "${LENGHT}"
  ${LINEBREAK} && echo '' 2> /dev/null
  return 0
}
