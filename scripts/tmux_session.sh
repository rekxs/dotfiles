#!/bin/bash
PID=`ps -eaf | grep "attach -t test" | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$PID" ]]; then
	#echo "killing $PID"
	#kill -9 $PID
	tmux detach
elif tmux list-sessions | grep test; 
then
	tmux attach -t test
else
	tmux new -s test
fi
