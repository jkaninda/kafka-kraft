#!/bin/bash
if [ $# -eq 0 ]
  then
    tag='latest'
  else
    tag=$1
fi

 echo 'Build latest'
 docker build -f ./docker/amd64/8.1/Dockerfile -t jkaninda/laravel-php-fpm:$tag .
 

