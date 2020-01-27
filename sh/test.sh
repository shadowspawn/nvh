#!/bin/sh

if [ "$1" = "true" ]; then
  echo "param is the string true"
else
  echo "param is not the string true"
fi

if [ -z "$1" ] ; then
  echo "param is empty"
else
  echo "param is not empty"
fi

if [ -n "${1+defined}" ] ; then
  echo "param is defined"
else
  echo "param is undefined"
fi
