errors[0]='Inconsistent bioStart and bioEnd values' 
errors[1]='Inconsistent precedes and relative position'
errors[2]='javax.xml.bind.UnmarshalException null'
errors[3]='Multiple objects with same URI'
errors[4]='Part name not found'

for e in "${errors[@]}";
do
    grep """$e""" stderr.log | wc -l| awk -v error="$e" '{ print $1"	" error}'
done
