#!/bin/bash
if [ $# -eq 0 ]
  then
    tag='latest'
  else
    tag=$1
fi

 echo 'Build latest'
 docker build -f ./docker/Dockerfile -t jkaninda/kafka-kraft:$tag .
 

