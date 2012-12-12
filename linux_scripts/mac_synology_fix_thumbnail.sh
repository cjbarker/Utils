#!/usr/bin/env bash
# ******************************************
# Fixes greyed icon preview from display
# on external NTFS formated drive.
#
# Note: See Synology error
# http://forum.synology.com/enu/viewtopic.php?f=64&t=41329
# ******************************************

# very cmd args - if dir and if recursion

function valid_xcode()
{
    local  _returnvar=$1
    local  _result=0

    which /Developer/Tools/GetFileInfo > /dev/null
    if [ $? -eq 1 ]; then
        _result=1
        echo "Missing /Developer/Tools/GetFileInfo -> Install XCode."
    fi

    which /Developer/Tools/SetFile > /dev/null
    if [ $? -eq 1 ]; then
        _result=1
        echo "Missing /Developer/Tools/SetFile -> Install XCode."
    fi

    # return result
    if [[ "$_returnvar" ]]; then
        eval $_returnvar="'$_result'"
    else
        echo "$_result"
    fi
}

valid_xcode no_xcode
if [ $no_xcode -eq 1 ]; then
    exit 1
fi

# load all files to process
# TODO read in via CLI args rather 
dirs=(2007 2006 2005 2004 2003 2002 2001 2000)

for d in ${dirs[@]}
do
    echo "Processing Dir: $d"
    find ./${d} -type f -print0 | xargs -0 /Developer/Tools/SetFile -c "" -t ""
done

#find ./198* -type f -print0 | xargs -0 /Developer/Tools/SetFile -c "" -t ""
