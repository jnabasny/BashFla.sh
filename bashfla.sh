#! /bin/bash
# Name:		BashFlash
# Purpose:	Designed for studying
#			a foreign language, but
#			can be used with any
#			content
# Rev:		March 26, 2022
#
# by
# Jake Nabasny
# jake.nabasny.com

## Settings
replay_wrong_answers=1
shuffle=0

## Variables
file="$1"
right=0
wrong=0
line=1
length=`cat "$file" | wc -l`
pass=1

if [ "$shuffle" = 1 ]; then
	file=`cat "$file" | awk 'NR == 1; NR > 1 {print $0 | "shuf"}' > /tmp/shuffled.csv`
	file=/tmp/shuffled.csv
fi

## Main function
quiz() {

slang=`awk -F, '{print $2}' "$file" | head -1`
dlang=`awk -F, '{print $1}' "$file" | head -1`

while IFS="," read -r col1 col2 col3
do
	echo -e "\n$slang: $col2 ($col3)"
	read -p "$dlang: " guess </dev/tty
	guess=`echo $guess | tr '[:upper:]' '[:lower:]'`
	col1=`echo $col1 | tr '[:upper:]' '[:lower:]'`
	if [ "$guess" = "$col1" ]; then
		right=$(("$right"+1))
		echo -e "\nRight: $right - Wrong: $wrong\n"
	else
		wrong=$(("$wrong"+1))
		echo -e "\nRight: $right - Wrong: $wrong\n"
		echo -e "CORRECT ANSWER: $col1\n"
		if (( "$pass" == 0 )); then
			echo "$col1,$col2,$col3" >> /tmp/wrong.csv
		fi
	fi

	((line++))

	if (( "$line" == "$length" )); then
		if [ "$replay_wrong_answers" = 1 ]; then
			file=/tmp/wrong.csv
			pass=2
			quiz
		fi
		if (( "$pass" == 2 )); then
			echo -e "\nCongratulations! You've completed the cards with $right right answers.\n"
			if [ -f /tmp/shuffled.csv ]; then rm /tmp/shuffled.csv; fi
			rm /tmp/wrong.csv
			exit
		fi
	fi

done < <(tail -n +2 "$file")

}


case "$1" in
	'')
		echo "Usage: $0 [file]"
		exit
	;;
	*)
		if [ ! -f "$1" ]; then
				echo "Input file does not exist!"
				exit 1
		fi
		quiz
	;;
esac
