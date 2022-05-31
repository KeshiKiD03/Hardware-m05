#!/bin/bash
opcio="dia"
if [ $# -eq 1 ]; then
  opcio=$1
fi

case $opcio in
  "dia")
      date;;
  "sysinfo")
      cat /etc/os-release;;
  "calendari")
      cal;;
esac
