#!/bin/bash

case $1 in

  exit)
    exit 0
    ;;

  shell)
	cd /opt/esp/src
    /bin/bash
    ;;

  init)
	cd /opt/esp/src
    cp -r $IDF_PATH/examples/get-started/hello_world/* .
    make menuconfig
    ;;

  *)
	cd /opt/esp/src
	$@
    ;;
esac
