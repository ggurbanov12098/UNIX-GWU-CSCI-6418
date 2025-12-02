#!/bin/bash
# custom_man_date.sh
# shows: FORMAT  EXAMPLE  DESCRIPTION for the current date/time.

# Optional colors (only if stdout is terminal)
if [ -t 1 ]; then
  C_FMT=$'\e[1;36m'    # cyan, bold   for format code
  C_EX=$'\e[1;32m'     # green, bold  for example
  C_DESC=$'\e[0m'      # default      for description
  C_HDR=$'\e[1;33m'    # yellow, bold for header
  C_RESET=$'\e[0m'
else
  C_FMT=""; C_EX=""; C_DESC=""; C_HDR=""; C_RESET=""
fi

echo "${C_HDR}=== date format cheat-sheet ===${C_RESET}"
echo
echo "Synopsis:"
echo "  date [OPTION]... [+FORMAT]"
echo
echo "Examples:"
echo "  date +\"%Y-%m-%d\"     # ISO-like date"
echo "  date +\"%H:%M:%S\"     # 24h time"
echo

# Header for the table
printf '%-8s %-24s %s\n' "FORMAT" "EXAMPLE" "DESCRIPTION"
printf '%-8s %-24s %s\n' "------" "-------" "-----------"

# List of: FORMAT|DESCRIPTION
formats=(
  "%%|literal %"
  "%a|abbreviated weekday name"
  "%A|full weekday name"
  "%b|abbreviated month name"
  "%B|full month name"
  "%c|locale date and time"
  "%C|century (year / 100)"
  "%d|day of month (01..31)"
  "%D|date as %m/%d/%y"
  "%e|day of month, space padded"
  "%F|full date (YYYY-MM-DD)"
  "%g|ISO week-year (last two digits)"
  "%G|ISO week-year"
  "%h|same as %b (abbrev month)"
  "%H|hour (00..23)"
  "%I|hour (01..12)"
  "%j|day of year (001..366)"
  "%k|hour, space padded ( 0..23)"
  "%l|hour, space padded ( 1..12)"
  "%m|month (01..12)"
  "%M|minute (00..59)"
  "%n|newline character"
  "%N|nanoseconds (000000000..999999999)"
  "%p|AM/PM equivalent"
  "%P|am/pm in lowercase"
  "%q|quarter of year (1..4)"
  "%r|12-hour time with AM/PM"
  "%R|24-hour time, hh:mm"
  "%s|seconds since the Epoch"
  "%S|second (00..60)"
  "%t|tab character"
  "%T|time as %H:%M:%S"
  "%u|day of week (1..7, Mon=1)"
  "%U|week num, Sunday first (00..53)"
  "%V|ISO week num, Monday first (01..53)"
  "%w|day of week (0..6, Sun=0)"
  "%W|week num, Monday first (00..53)"
  "%x|locale date"
  "%X|locale time"
  "%y|year (last two digits)"
  "%Y|year (4+ digits)"
  "%z|numeric timezone +hhmm"
  "%:z|numeric timezone +hh:mm"
  "%::z|numeric timezone +hh:mm:ss"
  "%:::z|timezone to needed precision"
  "%Z|alphabetic timezone abbreviation"
)

for entry in "${formats[@]}"; do
  IFS='|' read -r fmt desc <<< "$entry"

  # For %n and %t, show escaped version so the table stays in one line
  case "$fmt" in
    "%n") example="\n" ;;
    "%t") example="\t" ;;
    *)    example=$(date "+$fmt") ;;
  esac

  printf '%b%-8s%b %b%-24s%b %b%s%b\n' \
    "$C_FMT"  "$fmt"   "$C_RESET" \
    "$C_EX"   "$example" "$C_RESET" \
    "$C_DESC" "$desc"  "$C_RESET"
done
