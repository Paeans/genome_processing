
while read -ra line; do

cat all_mutations.csv | grep ",""${line[0]}""," | awk -F',' '{print substr($4, 4) "\t" $5 "\t" $6}' | sort -k1,1 -k2,2n > ${line[1]}.txt

wc -l ${line[1]}.txt

for mode in b l r; do

for length in 200 1000; do

python3 get_seq.py -f hg38.fa -p ${line[1]}.txt -m ${mode} -l ${length}

echo human_${mode}_flanking_${length}.txt human_${mode}_flanking_${length}_${line[1]}.txt
mv human_${mode}_flanking_${length}.txt human_${mode}_flanking_${length}_${line[1]}.txt

wc -l human_${mode}_flanking_${length}_${line[1]}.txt

done

done

rm ${line[1]}.txt
done < mutation_name.txt
