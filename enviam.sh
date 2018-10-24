subj=$1
filename=$2

if [ -r $filename ];
then
rm /tmp/$$
echo $subj >/tmp/$$
filename=/tmp/$$
fi

# echo +++++ filename: [ $filename ]

/usr/bin/perl /home/cassandra/send.pl origen@domain.cl destino@domain.cl destino_cc@domain.cl "$subj"  "$filename"

rm $filename

