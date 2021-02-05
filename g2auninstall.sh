#!/bin/bash
#
# Version 1.0.2
## Functions
# Creates a local function to move to trash instead of permanently deleting.
function trash () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      # remove trailing slash
      local mindtrailingslash=${path%/}
      # remove preceding directory path
      local dst=${mindtrailingslash##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$(expr "$dst" : '\(.*\)\.[^.]*') $(date +%H-%M-%S).$(expr "$dst" : '.*\.\([^.]*\)')"
      done
      mv "$path" ~/.Trash/"$dst" && echo "$path moved to trash" || echo "Failed to trash $path"
    fi
  done
}
#
## Remove Plist Files
    gtarsPlistIds=("com.citrixonline.g2ax*"
                   "com.citrixonline.g2a*"
                   "com.citrixonline.g2ars*"
                   "com.citrixonline.GoToAssist*"
                   "com.logmein.g2a*"
                   "com.logmein.g2ars*"
		   "com.logmein.GoToManage*"
                   "com.logmein.GoToAssist*")

#
## Remove application files
    appLocations=("/Library/Application\ Support/CitrixOnline/GoToAssist\ Customer"
                  "$HOME/Library/Application\ Support/CitrixOnline/GoToAssist\ Customer"
                  "/Library/Application\ Support/GoToAssist/GoToAssist\ Customer"
                  "/Library/Preferences"
                  "$HOME/Library/Preferences"
                  "/Library/LaunchAgents"
                  "$HOME/Library/LaunchAgents"
                  "/Library/LaunchDaemons"
                  "$HOME/Library/LaunchDaemons"
                  "/Library/StartupItems"
                  "$HOME/Library/StartupItems"
                  "$HOME/Library/Application\ Support/GoToAssist/GoToAssist\ Customer"
                  "/Library/Application\ Support/GoToAssist/GoToAssist\ Customer")
    for appLoc in "${appLocations[@]}"; do
	for plistId in "${gtarsPlistIds[@]}"; do
		trash "$appLoc"/"$plistId"
		trash "$appLoc"/"$plistId".plist
	done
    done
