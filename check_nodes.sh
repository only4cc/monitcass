#!/bin/bash
# JTS
# check_nodes.sh 
# Objetivo: Revisar disponibilidad de los nodos del cluster de Banco Estado
#


RET=0

#RET=`/home/cassandra/apache-cassandra-3.11.3/bin/nodetool -h 192.168.171.63 status`
#RET=`/home/cassandra/apache-cassandra-3.11.3/bin/nodetool -h 192.168.171.63 status | egrep "UN" | wc -l`
#RET=`/home/cassandra/apache-cassandra-3.11.3/bin/cqlsh 192.168.171.63 -e "desc keyspaces"`

RET=`/usr/bin/perl /home/cassandra/check.pl`
echo === Nodos: $RET ===

RET=5

if [ "$RET" == 6 ]
then
echo "seis nodos arriba"
exit 0
else
NOW=$(date +"%d-%m-%Y")
MSG="$NOW - Cassandra: Cluster Banco Estado - Nodos arriba $RET es distinto a 6"
echo $MSG
# logger -s $MSG
# /home/cassandra/enviam.sh "$MSG"
exit -1
fi


