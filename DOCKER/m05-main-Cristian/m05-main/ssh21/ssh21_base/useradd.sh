#!/bin/bash

for user in pere marta anna pau jordi julia
do
	useradd -m $user
	echo $user:$user | chpasswd 
done
