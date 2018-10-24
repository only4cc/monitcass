# Verificacion basica de Nodos del Cluster 
my $DEBUG = 0;

my @IPS=('192.168.X1.Y1', '192.168.X1.Y2', '192.168.X1.Y3',
         '192.168.X2.Y1', '192.168.X2.Y2', '192.168.X2.Y3' );

my $cluster_name = shift || 'NOMBRE_DEL_CLUSTER';  # <<< Ajustar al nombre del Cluster a Monitorear
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
