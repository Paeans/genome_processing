
cat all_mutations.csv | awk -F',' '{print substr($4, 4) " " $5 " " $7 " " $1}' > tmp_position.txt

while read -ra line; do

cat tmp_position.txt | grep "${line[0]}"  | awk -v var="${line[1]}" '{print $1 " " $2 " " var " " $4}' >> tmp_list.txt

done < mutation_name.txt

cat tmp_list.txt | sort -k1,1 -k2,2n >> mutation_position.txt

rm tmp_list.txt tmp_position.txt