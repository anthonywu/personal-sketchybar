#!/bin/zsh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="􀛨"
  ;;
  [6-8][0-9]) ICON="􀺸"
  ;;
  [3-5][0-9]) ICON="􀺶"
  ;;
  [1-2][0-9]) ICON="􀛩"
  ;;
  *) ICON="􀛪"
esac

LABEL="${PERCENTAGE}%"

# if charger is connected, override the battery percentage icon
charger_info=$(system_profiler -json SPPowerDataType | jq -r '.SPPowerDataType.[] | select(has("sppower_ac_charger_watts"))')
if [ "$(jq -r '.sppower_battery_charger_connected' <(echo $charger_info))" = "TRUE" ]; then
  WATTAGE=$(jq -r '.sppower_ac_charger_watts' <(echo $charger_info))
  if [ "$(jq -r '.sppower_battery_is_charging' <(echo $charger_info))" = "TRUE" ]; then
    # connected and charging
    ICON="􁐓"
    LABEL="Charging – ${WATTAGE}W"
  else
    # connected but not charging battery, i.e. battery life management
    ICON="􀷄"
    LABEL="Fully Charged – ${WATTAGE}W"
  fi
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${LABEL}"
