#!/bin/bash
#yum -y install wget
#
##client dl
#while true
#do
#sleep 2
#test -e ./source/kubernetes-client-linux-amd64.tar.gz
#  if [[ $? != 0 ]]; then
#    wget -P ./source/ https://dl.k8s.io/v1.10.4/kubernetes-client-linux-amd64.tar.gz
#  else
#    client="`sha256sum ./source/kubernetes-client-linux-amd64.tar.gz | cut -d " " -f 1`"
#    if [[ $client == "2831fe621bf1542a1eac38b8f50aa40a96b26153e850b3ff7155e5ce4f4f400e" ]]; then
#      break
#    else
#      rm -rf ./source/kubernetes-client-linux-amd64.tar.gz
#      wget -P ./source/ https://dl.k8s.io/v1.10.4/kubernetes-client-linux-amd64.tar.gz
#    fi
#  fi
#done
#
##server dl
#while true
#do
#sleep 2
#test -e ./source/kubernetes-server-linux-amd64.tar.gz
#  if [[ $? != 0 ]]; then
#    wget -P ./source/ https://dl.k8s.io/v1.10.4/kubernetes-server-linux-amd64.tar.gz
#  else
#    client="`sha256sum ./source/kubernetes-server-linux-amd64.tar.gz | cut -d " " -f 1`"
#    if [[ $client == "e2381459ba91674b5e5cc10c8e8d6dc910e71874d01165ca07a94188edc8505e" ]]; then
#      break
#    else
#      rm -rf ./source/kubernetes-server-linux-amd64.tar.gz
#      wget -P ./source/ https://dl.k8s.io/v1.10.4/kubernetes-server-linux-amd64.tar.gz
#    fi
#  fi
#done
#
##docker dl
#while true
#do
#sleep 2
#test -e ./source/docker-18.03.1-ce.tgz
#  if [[ $? != 0 ]]; then
#    wget -P ./source/ https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
#  else
#    client="`sha256sum ./source/docker-18.03.1-ce.tgz | cut -d " " -f 1`"
#    if [[ $client == "0e245c42de8a21799ab11179a4fce43b494ce173a8a2d6567ea6825d6c5265aa" ]]; then
#      break
#    else
#      rm -rf ./source/docker-18.03.1-ce.tgz
#      wget -P ./source/ https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
#    fi
#  fi
#done

yum -y install wget

declare -a verArr=() fnameArr=() sumArr=() urlArr=()
source funcs.sh

#https://kubernetes.io/docs/setup/release/notes/
verArr['k8s_client']="v1.10.4"
sumArr['k8s_client']="2831fe621bf1542a1eac38b8f50aa40a96b26153e850b3ff7155e5ce4f4f400e"
fnameArr['k8s_client']="kubernetes-client-linux-amd64.tar.gz"
urlArr['k8s_client']="https://dl.k8s.io/${verArr['k8s_client']}/kubernetes-client-linux-amd64.tar.gz"

verArr['k8s_server']="v1.10.4"
hashArr['k8s_server']="e2381459ba91674b5e5cc10c8e8d6dc910e71874d01165ca07a94188edc8505e"
fnameArr['k8s_server']="kubernetes-server-linux-amd64.tar.gz"
urlArr['k8s_server']="https://dl.k8s.io/${verArr['k8s_client']}/kubernetes-client-linux-amd64.tar.gz"

#https://download.docker.com/
fnameArr['docker']="docker-18.03.1-ce.tgz"
sumArr['docker']="0e245c42de8a21799ab11179a4fce43b494ce173a8a2d6567ea6825d6c5265aa"
urlArr['docker']="https://download.docker.com/linux/static/stable/x86_64/${fnameArr['docker']}"

CnsDownload k8s_client
CnsDownload k8s_server
CnsDownload docker
