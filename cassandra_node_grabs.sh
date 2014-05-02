#!/bin/bash -u
env=${1}
cnodes=`cat <path>/cassandra_nodes_${env}.lst`
tstamp=`date +%Y%m%d%s`
datadir=<output_path>
for cnode in ${cnodes}
do
        mkdir -pv ${datadir}/cassandra_${cnode}_${tstamp}
        if [ "${env}" = "dev" ]; then
                scp ${cnode}:/apps/cassandra-storage/logs/system.log ${datadir}/cassandra_${cnode}_${tstamp}/
                ssh ${cnode} "du -sh /apps/cassandra-storage/data" > ${datadir}/cassandra_${cnode}_${tstamp}/du_sum.lst
                ssh ${cnode} "du -h --max-depth=1 /apps/cassandra-storage/data" > ${datadir}/cassandra_${cnode}_${tstamp}/du_detail.lst
        else
                scp ${cnode}:/data/cassandra/logs/system.log ${datadir}/cassandra_${cnode}_${tstamp}/
                ssh ${cnode} "du -sh /data/cassandra/data/" > ${datadir}/cassandra_${cnode}_${tstamp}/du_sum.lst
                ssh ${cnode} "du -h --max-depth=1 /data/cassandra/data/" > ${datadir}/cassandra_${cnode}_${tstamp}/du_detail.lst
        fi
        ssh ${cnode} "top -n 1 -b" > ${datadir}/cassandra_${cnode}_${tstamp}/top.lst
        ssh ${cnode} "iostat -x d 1 5" > ${datadir}/cassandra_${cnode}_${tstamp}/iostatx.lst
        scp  ${cnode}:/apps/cassandra/conf/* ${datadir}/cassandra_${cnode}_${tstamp}/
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" cassandra-cli -h localhost -f /apps/cassandra/projects/show_schema.cli' > ${datadir}/cassandra_${cnode}_${tstamp}/schema.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" cassandra-cli -h localhost -f /apps/cassandra/projects/show_keyspaces.cli' > ${datadir}/cassandra_${cnode}_${tstamp}/keyspaces.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" cassandra-cli -h localhost -f /apps/cassandra/projects/describe_clus.cli' > ${datadir}/cassandra_${cnode}_${tstamp}/describe_clus.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" nodetool -h localhost ring' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_ring.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" nodetool -h localhost info' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_info.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" nodetool -h localhost tpstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_tpstats.lst
        ssh -t ${cnode} 'export JAVA_HOME="/apps/java/jdk-1.6"; PATH="/apps/python/bin/:${PATH}:/apps/cassandra/bin/" nodetool -h localhost cfstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_cfstats.lst
done
tar -cvf ${datadir}/cassandra-grabs.${tstamp}.tar ${datadir}/cassandra_*_${tstamp}
gzip ${datadir}/cassandra-grabs.${tstamp}.tar
echo "cassandra info grabbed"

