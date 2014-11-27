#!/bin/sh
APP=uzbl-browser

if test ! $(which $APP)
then
	 echo "  Installing $APP for you."
	 $PACKMANAGER $APP > /tmp/$APP-install.log
    fi

unset APP
