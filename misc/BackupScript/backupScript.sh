#!/bin/bash
echo -e "\e[1;31;107mPC to card\e[0m"
source="/path/to/source/."
destination="/parth/to/destination"
#echo $source
#echo $destination
# --progress
rsync -aXS --dry-run --progress --delete-after $source $destination
read -p 'Do you want to Sync new files and remove (in destination) deleted files (in source)? (Y/n) : ' opt0
# echo $opt0
case $opt0 in
	# check for O (Yes) answer
	[y,Y] ) echo -e "\e[32mrsync will sync files and remove deleted\e[0m"
	sleep 3
	rsync -aXS --progress --stats --delete-after $source $destination
	;;
	# check for N (No) answer
	[n,N] ) echo -e "\e[32mrsync will not remove (in destination) deleted (in source)\e[0m"
	read -p 'Do you want to Sync new files without removing deleted files? (Y/n) : ' opt1
	# echo $opt1
	case $opt1 in
		# check for Y (Yes) answer
		[y,Y] ) echo -e "\e[32mrsync will sync files, but will not remove deleted\e[0m"
		rsync -aXS --progress --stats $source $destination
		;;
		# check for N (No) answer
		[n,N] ) echo -e "\e[31mNothing Done At All\e[0m"
		;;
		# check for anything else
		* ) echo -e "\e[31mnot a valid input, exiting\e[0m"
		;;
	esac
	;;
	# check for anything else
	* ) echo -e "\e[31mnot a valid input, exiting\e[0m"
	;;
esac
echo "exiting"
sleep 10
exit
