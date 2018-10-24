# Verificacion basica de Nodos del Cluster 
my $DEBUG = 0;

my @IPS=('192.168.171.63', '192.168.171.64', '192.168.171.65',
         '192.168.161.63', '192.168.161.64', '192.168.161.65' );

my $cluster_name = shift || 'BE0ORCHP-CASS0C';
my $CMD;
my $tot_ok = 0;
foreach my $ip ( @IPS ) {
   $CMD="/home/cassandra/apache-cassandra-3.11.3/bin/cqlsh $ip -e \"desc cluster\;\"";
   print "Verificando $CMD ...\n" if $DEBUG;
   my $resp = `$CMD | egrep -i $cluster_name`;
   print $resp. "\n" if $DEBUG;
   ++$tot_ok if ( $resp =~ /$cluster_name/ );
}
print  $tot_ok;
