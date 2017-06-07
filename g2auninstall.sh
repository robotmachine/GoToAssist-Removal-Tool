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
## Remove application
trash /Library/Application\ Support/CitrixOnline/GoToAssist\ Customer
trash /Library/Preferences/com.citrixonline.GoToAssist\ Express.plist
trash /Library/Preferences/com.citrixonline.GoToManage.plist
trash /Library/LaunchAgents/com.citrixonline.g2ax.customer.LaunchAgent.plist
trash /Library/LaunchDaemons/com.citrixonline.g2ax.customer.CommAgent.plist
