#!/bin/bash
#
# Author: cnscn <214363570@qq.com>
# Date: 2020/12/12
# Usage:
:<<_DOC_
  #arrays
  declare -a verArr=() fnameArr=() sumArr=() urlArr=()
  
  #https://download.docker.com/
  fnameArr['docker']="docker-18.06.3-ce.tgz"
  sumArr['docker']="346f9394393ee8db5f8bd1e229ee9d90e5b36931bdd754308b2ae68884dd6822"
  urlArr['docker']="https://download.docker.com/linux/static/stable/x86_64/${fnameArr['docker']}"

  #check
  CnsFCheck $_path/$_fname $_sum

  @return 
     0 only file exists (when no checksum arg)  or  file exists and checksum ok
     1 file not exists or checksum failed
_DOC_

function CnsFCheck(){
   _f=$1
   _fsum=${2:=}

   if [ -z $_fsum ]
   then
     if [ -f $_f ]
     then
        echo $_f exists ... ok
        return 0
     else
        echo $_f does not exists  ... failed
        return 1
     fi
   else
     if [[ -f $_f  &&  $(sha256sum $_f | cut -d " " -f 1) = $_fsum ]]
     then
        echo $_f exists and checksum ok
        return 0
     else
        echo $_f does not exists or checksum failed
        return 1
     fi 
   fi
}

:<<_DOC_
  Usage: CnsDownload docker
_DOC_
function CnsDownload() {
  _app=$1

  _fname=${fnameArr[$_app]}
  _sum=${sumArr[$_app]}
  _url=${urlArr[$_app]}
  _path=./source

  test -d $_path || mkdir $_path || return 1

  _times=0
  while ! CnsFCheck $_path/$_fname $_sum
  do
      rm -rf $_path/$_fname
      wget -c  "$_url" -O $_path/$_fname
      (( _times++ ))
      if [ $_times -gt 240 ] 
      then
          echo download $_f tried too many times ... failed
          break
      fi
      sleep 5
  done
}

#to download
#CnsDownload docker
