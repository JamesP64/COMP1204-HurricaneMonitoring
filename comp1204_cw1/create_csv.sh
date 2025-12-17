#!/bin/bash
#$1 is input 1, $2 is input 2
#Firstly, clearing the output file
truncate -s 0 $2
#Grabbing all lines of the input file with <tr> tag
#Replacing all tags with nothing
#Removing the 10 blank spaces at the start of the remaining lines
#Removing lines that contain '2020'
#Removing anything after a ; on each line
#Removing lines that contain :
#Removing an extra whitespace every 4 lines, starting on the second line
#Removing every space after a comma
#Combining every two lines,seperating with a whitespace
#Repeating so every 4 lines are combined
grep "<tr>" $1 | sed 's/<[^>]*>//g' | sed -r 's/^.{10}//' | sed -n '/2020/!p' | sed 's/;.*//;/^$/d' | sed "/\:$/d" | sed -r '2~4s/^.{1}//' | sed 's/, */,/g'| sed 'N;s/\n/,/' | sed 's/[[:space:]]*$//'| sed 'N;s/\n/,/'> $2
#Adds header to the top of the file
echo "Timestamp,Latitude,Longitude,MinSeaLevelPressure,MaxIntensity" | cat - $2 > temp && mv temp $2
