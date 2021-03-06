#!/bin/bash
if [ -e file8.txt ];then
    rm file8.txt
fi
var=$1
n=$(echo ${#var})
m=0
declare -a List=()
while((m<n))
do
    List[m]=$(echo ${var:$m:1})
    ((m=m+1))
done
#echo ${List[@]}
cat dico4.utf8 | awk -F " " '{print $1}' > file.txt
for i in ${List[*]}
do
    cat file.txt | grep $i > file7.txt
    rm file.txt
    cat file7.txt > file.txt
done
echo -e "Mots contenant cet ensemble de lettres"
cat file.txt
echo -e "-------------------------------"
while read part
do
    mot_length=$(echo ${#part})
    l=0
    while((l<$mot_length));do
	ss_mot=$(echo ${part:$l:1})
	echo ${List[*]} | grep $ss_mot >> file10.txt
	retvalue=$?
	if [ $retvalue != 0 ];then
 	    sed '/^'$part'/d' file.txt > file9.txt
	    rm file.txt
	    cat file9.txt > file.txt
	fi
        ((l=l+1))
    done
done<file.txt
echo -e "Le mot qui contient exactement un sous-emsemble(sens large) de la liste de len max"
cat file.txt 
rm *.txt
