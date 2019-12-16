
while read line; do

cat all_mutations.csv | grep "^""$line" | awk -F',' '{print substr($4, 4) "\t" $5 "\t" $6}' | sort -k1,1 -k2,2n > $line.txt

wc -l $line.txt

for mode in b l r; do

for length in 200 1000; do

python3 get_seq.py -f hg38.fa -p $line.txt -m ${mode} -l ${length}

echo human_${mode}_flanking_${length}.txt human_${mode}_flanking_${length}_${line}.txt
mv human_${mode}_flanking_${length}.txt human_${mode}_flanking_${length}_${line}.txt

wc -l human_${mode}_flanking_${length}_${line}.txt

done

done

rm $line.txt

done < cancer_name.txt
