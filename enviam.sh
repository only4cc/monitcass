subj=$1
filename=$2

if [ -r $filename ];
then
rm /tmp/$$
echo $subj >/tmp/$$
filename=/tmp/$$
fi

# echo +++++ filename: [ $filename ]

/usr/bin/perl /home/cassandra/send.pl eco_dba@e-contact.cl ArquitecturaDB@e-contact.cl jtrumper@e-contact.cl "$subj"  "$filename"

rm $filename

