#!/bin/bash -u
env=${1}
app=${2}
cnodes=`cat cassandra_nodes_${env}.lst`
tstamp=`date +%Y%m%d%s`
datadir=/tmp
for cnode in ${cnodes}
do
        mkdir -pv ${datadir}/spark_${cnode}_${tstamp}
                 rsync  -avh ${cnode}:/data/log/spark/*.log ${datadir}/spark_${cnode}_${tstamp}/
		 rsync  -avh --max-size=2m ${cnode}:/data/spark/work/ ${datadir}/spark_${cnode}_${tstamp}
#                 rsync  -avh ${cnode}:/data/spark/work/ ${datadir}/spark_${cnode}_${tstamp}
#		 find ${datadir}/spark_${cnode}_${tstamp} -name *.jar -exec rm -vrf {} \;
#                 ssh ${cnode} "mkdir -pv ${datadir}/spark_${cnode}_${tstamp}" 
#                 ssh ${cnode} "rsync -avz -e ssh --files-from=<(find ${app} -name std*) /data/spark/work/ ${datadir}/spark_${cnode}_${tstamp}/" 
#                 rsync  -avhr ${cnode}:${datadir}/spark_${cnode}_${tstamp}/ ${datadir}/spark_${cnode}_${tstamp}/
done
tar -cvf ${datadir}/spark-grabs.${tstamp}.tar ${datadir}/spark_*_${tstamp}
gzip ${datadir}/spark-grabs.${tstamp}.tar
echo "spark info grabbed"

