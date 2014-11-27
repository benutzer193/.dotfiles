#!/bin/sh
APP=ranger

if test ! $(which $APP)
then
	 export APPS="$APPS $APP"
	 echo -e "\033[0,31m Adding $APP to apps being installed."
 fi

export APPS="$APPS"
unset APP
