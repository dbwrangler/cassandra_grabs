#!/bin/bash -u
env=${1}
pause=${2}
cnodes=`cat <path>/cassandra_nodes_${env}.lst`
tstamp=`date +%Y%m%d`
datadir=<outputpath>
while true
do
        for cnode in ${cnodes}
        do
                mkdir -pv ${datadir}/cassandra_stats_${cnode}_${tstamp}
                ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" date; echo "#########"; nodetool -h localhost tpstats; iostat -x -d 1 1; top -bn 1' >> ${datadir}/cassandra_stats_${cnode}_${tstamp}/cassandra_stats.lst
        done
        sleep ${pause}
done
tar -cvf ${datadir}/cassandra-grabs.tar cassandra_*_${tstamp}
gzip ${datadir}/cassandra-grabs.tar
echo "cassandra stats grabbed"

