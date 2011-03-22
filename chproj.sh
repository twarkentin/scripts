#!/bin/bash

# -----------------------------------------------------------------------------
# FILE NAME      : chproj.bashrc
# CURRENT AUTHOR : Tim Warkentin
# AUTHOR'S EMAIL : tim.warkentin@gmail.com
# -----------------------------------------------------------------------------
# PURPOSE: Bash script to configure the environment to a specific FPGA project.
# -----------------------------------------------------------------------------

if [ $# -eq 0 ]; then
  echo "USAGE: chproj <project_name> [revision]"
  return
fi

if [ ! -d "/projects/$1" ]; then
  echo "Project '${1}' does not exist"
  return
fi

export project_rev=""

if [ $# -eq 2 ]; then 
  if [ ! -d "/projects/$1/rev$2" ]; then
    echo "${1} project revision '${2}' does not exist"
    return
  else
    export project_rev="$2"
  fi
fi

export project_name="$1"
if [ -z "$project_rev" ]; then
  export project_path="/projects/$project_name"
else
  export project_path="/projects/$project_name/rev$project_rev"
fi

export svn_repo="http://granite.mtil/projects"
export svn_project="$svn_repo/$project_name$project_rev"
export LD_LIBRARY_PATH="/tools/grid_engine/lib/lx24-amd64:/tools/grid_engine/lib/lx24-amd64:/usr/lib:/usr/local/lib:/usr/dt/lib:/usr/openwin/lib:/usr/lib:/lib:/usr/lib/sparcv9"
export global_lib="/projects/lib"

export proj="$project_path"
export project="$project_path"

export project_builds="$project_path/builds"
export project_archive="$project_path/archive"
export project_setup="$project_path/setup"
export project_local="/var/tmp/$project_name$project_rev"

export builds="$project_path/builds"
export proj="$project_path"
export no_modules="0"


function  chbld () { 
  source "/projects/scripts/chbld.bashrc" 
}
export -f chbld 

function  version_setup () { 
  /projects/scripts/version_setup.pl "$@"
}
export -f version_setup

function  lsblds () { 
  ls -1 "$builds" 
}
export -f lsblds

alias io='/projects/scripts/io.pl'

export build_name=""
export blk_name=""

export project_cfg="[$txt_color$project_name$project_rev$txt_rst] "

