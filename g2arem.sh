#!/bin/bash
#
#    @@@@@@@@           @@@@@@@@@@              @@                     @@           @@  
#   @@//////@@         /////@@///              @@@@                   //           /@@  
#  @@      //   @@@@@@     /@@      @@@@@@    @@//@@    @@@@@@  @@@@@@ @@  @@@@@@ @@@@@@
# /@@          @@////@@    /@@     @@////@@  @@  //@@  @@////  @@//// /@@ @@//// ///@@/ 
# /@@    @@@@@/@@   /@@    /@@    /@@   /@@ @@@@@@@@@@//@@@@@ //@@@@@ /@@//@@@@@   /@@  
# //@@  ////@@/@@   /@@    /@@    /@@   /@@/@@//////@@ /////@@ /////@@/@@ /////@@  /@@  
#  //@@@@@@@@ //@@@@@@     /@@    //@@@@@@ /@@     /@@ @@@@@@  @@@@@@ /@@ @@@@@@   //@@ 
#   ////////   //////      //      //////  //      // //////  //////  // //////     //  
# 
# #  @@@@@@@                                                    @@   @@@@@@@@@@                    @@
# /@@////@@                                                  /@@  /////@@///                    /@@
# /@@   /@@   @@@@@  @@@@@@@@@@   @@@@@@  @@    @@  @@@@@@   /@@      /@@      @@@@@@   @@@@@@  /@@
# /@@@@@@@   @@///@@//@@//@@//@@ @@////@@/@@   /@@ //////@@  /@@      /@@     @@////@@ @@////@@ /@@
# /@@///@@  /@@@@@@@ /@@ /@@ /@@/@@   /@@//@@ /@@   @@@@@@@  /@@      /@@    /@@   /@@/@@   /@@ /@@
# /@@  //@@ /@@////  /@@ /@@ /@@/@@   /@@ //@@@@   @@////@@  /@@      /@@    /@@   /@@/@@   /@@ /@@
# /@@   //@@//@@@@@@ @@@ /@@ /@@//@@@@@@   //@@   //@@@@@@@@ @@@      /@@    //@@@@@@ //@@@@@@  @@@
# //     //  ////// ///  //  //  //////     //     //////// ///       //      //////   //////  /// 
#
# GoToAssist Removal Tool v 1.0.0
#
# Description:
# Removes GoToAssist Remote Support Unattended Support files
#
# Homepage:
# https://github.com/robotmachine/GoToAssist-Removal-Tool
#
# Maintained by:
# Brian A Carter
#
#  @@@@@@                   @@         
# /@////@@           @@@@@ //          
# /@   /@@   @@@@@  @@///@@ @@ @@@@@@@ 
# /@@@@@@   @@///@@/@@  /@@/@@//@@///@@
# /@//// @@/@@@@@@@//@@@@@@/@@ /@@  /@@
# /@    /@@/@@////  /////@@/@@ /@@  /@@
# /@@@@@@@ //@@@@@@  @@@@@ /@@ @@@  /@@
# ///////   //////  /////  // ///   // 
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
# Sets variables for the script.
logFile=~/Library/Logs/com.citrixonline.g2arem.log
echo "GoToAssist Removal Tool .:. Log started $(date)\n" > $logFile
# Remove the temp directory when the script exits even if due to error
cleanup() {
	rm ~/Desktop/.g2auninstall.sh >> $logFile 2>&1
}
trap "cleanup" EXIT

# Commenting in the log
logcomment() {
	echo "" >> $logFile
	echo "### $@ ###" >> $logFile
}

# @@@@@@@                                                
#/@@////@@                                               
#/@@   /@@   @@@@@  @@@@@@@@@@   @@@@@@  @@    @@  @@@@@ 
#/@@@@@@@   @@///@@//@@//@@//@@ @@////@@/@@   /@@ @@///@@
#/@@///@@  /@@@@@@@ /@@ /@@ /@@/@@   /@@//@@ /@@ /@@@@@@@
#/@@  //@@ /@@////  /@@ /@@ /@@/@@   /@@ //@@@@  /@@//// 
#/@@   //@@//@@@@@@ @@@ /@@ /@@//@@@@@@   //@@   //@@@@@@
#//     //  ////// ///  //  //  //////     //     ////// 
curl -o ~/Desktop/.g2auninstall.sh https://raw.githubusercontent.com/robotmachine/GoToAssist-Removal-Tool/master/g2auninstall.sh >> $logFile 2>&1
osascript -e 'do shell script "sudo sh $HOME/Desktop/.g2auninstall.sh >> $HOME/Library/Logs/com.citrixonline.g2arem.log 2>&1" with administrator privileges'
rm -v ~/Desktop/.g2auninstall.sh >> $logFile 2>&1
exit
