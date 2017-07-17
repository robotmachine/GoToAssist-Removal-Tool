#!/bin/bash
#
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
        dst="`expr "$dst" : '\(.*\)\.[^.]*'` `date +%H-%M-%S`.`expr "$dst" : '.*\.\([^.]*\)'`"
      done
      mv "$path" ~/.Trash/"$dst" && echo "$path moved to trash" || echo "Failed to trash $path"
    fi
  done
}
#
## Remove Plist Files
    gtarsPlistTempDir="$TempDir/GoToAssist_RS_Plist"
    gtarsPlistIds=("com.citrixonline.g2ax.customer"
                   "com.citrixonline.g2ax.expert"
                   "com.citrixonline.g2ax"
                   "com.citrixonline.g2a.rs.plist"
                   "com.citrixonline.g2ars.plist"
                   "com.citrixonline.GoToAssist Remote Support"
                   "com.logmein.g2a.rs"
                   "com.logmein.g2ars"
                   "com.logmein.GoToAssist Remote Support"
                   "com.logmein.GoToAssist Remote Support.customer")
    for plistId in "${gtarsPlistIds[@]}"; do
        trash "$plistId".plist
    done
#
## Remove application files
    appLocations=("/Library/Application\ Support/CitrixOnline/GoToAssist\ Customer"
                  "/Library/Application\ Support/GoToAssist/GoToAssist\ Customer")
    for appLoc in "{$appLocations[@]}"; do
        trash "$appLoc"
    done
