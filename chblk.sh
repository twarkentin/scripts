#!/bin/bash

if [ $# -ne 1 ]; then
   echo "Usage: chblk <block_name>"
   return
fi

tmp_blk=`/projects/scripts/blk_check.pl $1`

if [ $? != 0 ]; then
   echo "Block '$1' does not exist. Valid blocks are: "
   /projects/scripts/blk_check.pl -h # Display available blocks
   #$build_setup/blk_check.pl -h # Display available blocks
   return
fi

export blk_name=$1
export block="$tmp_blk"
export blk="$block"
export $blk_name=$block
export docs="$blk/docs"
export rtl="$blk/rtl"
export scripts="$blk/scripts"
export sta="$blk/sta"
export synth="$blk/synth"
export quartus="$blk/quartus"
export tb="$blk/tb"
export tc="$blk/tc"
export sim="$blk/sim"
export sub="$blk/sub"



function sim () { 
   $sim/sim 
}
export -f sim

function bld () {
  echo "$@"
  $scripts/build.pl "$@"
}


export project_cfg="[$txt_color$project_name$project_rev$txt_rst|$txt_color$build_name$txt_rst|$txt_color$blk_name$txt_rst] "

