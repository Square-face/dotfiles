#!/bin/bash
name=$(playerctl metadata xesam:title)
artist=$(playerctl metadata xesam:artist)
if [[ -z $name ]] 
then
   # spotify is dead, we should die too.
   exit 0
fi
echo "$name"
