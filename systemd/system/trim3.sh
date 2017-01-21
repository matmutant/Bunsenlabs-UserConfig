#!/bin/sh
OutputFile="/home/matmutant/trim-output"
Touch="/bin/touch"
Date="/bin/date"
Fstrim="/sbin/fstrim"
if [ ! -w "$OutputFile" ]; then
	#if file doesn't exist it is created
	$Touch "$OutputFile"
fi
#appends date to file and then performs trim to / dir
$Date >> "$OutputFile" && $Fstrim -v / >> "$OutputFile"
$Date >> "$OutputFile" && $Fstrim -v /home >> "$OutputFile"

exit 0
