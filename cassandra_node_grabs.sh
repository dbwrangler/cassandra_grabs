#!/bin/bash -u
env=${1}
cnodes=`cat cassandra_nodes_${env}.lst`
tstamp=`date +%Y%m%d%s`
datadir=/tmp
for cnode in ${cnodes}
do
        echo "*****************************    $cnode"
        mkdir -pv ${datadir}/cassandra_${cnode}_${tstamp}
#                scp -r ${cnode}:/data/log/cassandra/system.log"(.[1-5]$)"  ${datadir}/cassandra_${cnode}_${tstamp}/
                scp -r ${cnode}:/data/log/cassandra/system.log  ${datadir}/cassandra_${cnode}_${tstamp}/
                scp -r "${cnode}:/data/log/cassandra/system.log".[1-5]$""  ${datadir}/cassandra_${cnode}_${tstamp}/
#                ssh ${cnode} "du -sh /data/cassandra/data/" > ${datadir}/cassandra_${cnode}_${tstamp}/du_sum.lst
#                ssh ${cnode} "du -h --max-depth=1 /data/cassandra/data/" > ${datadir}/cassandra_${cnode}_${tstamp}/du_detail.lst
        ssh ${cnode} "top -n 1 -b" > ${datadir}/cassandra_${cnode}_${tstamp}/top.lst
        ssh ${cnode} "iostat -x d 1 5" > ${datadir}/cassandra_${cnode}_${tstamp}/iostatx.lst
        rsync  -avh ${cnode}:/etc/dse/ ${datadir}/cassandra_${cnode}_${tstamp}/
#        scp  -r ${cnode}:/etc/dse/cassandra/* ${datadir}/cassandra_${cnode}_${tstamp}/

	        if [ "${cnode}" = 'cassandra170' ]; then
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show schema;" |cassandra-cli -h 10.40.246.170'  > ${datadir}/cassandra_${cnode}_${tstamp}/schema.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show keyspaces;" |cassandra-cli -h 10.40.246.170' > ${datadir}/cassandra_${cnode}_${tstamp}/keyspaces.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "describe cluster" |cassandra-cli -h 10.40.246.170' > ${datadir}/cassandra_${cnode}_${tstamp}/describe_clus.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" dsetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/dsetool_status.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_ring.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  info' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_info.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  tpstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_tpstats.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  cfstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_cfstats.lst
        fi

	
	if [ "${cnode}" = 'cassandra166' ]; then
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show schema;" |cassandra-cli -h 10.40.246.166'  > ${datadir}/cassandra_${cnode}_${tstamp}/schema.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show keyspaces;" |cassandra-cli -h 10.40.246.166' > ${datadir}/cassandra_${cnode}_${tstamp}/keyspaces.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "describe cluster" |cassandra-cli -h 10.40.246.166' > ${datadir}/cassandra_${cnode}_${tstamp}/describe_clus.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" dsetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/dsetool_status.lst
	        ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_ring.lst
	        ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  info' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_info.lst
	        ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  tpstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_tpstats.lst
	        ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  cfstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_cfstats.lst
	fi

        if [ "${cnode}" = 'cassandra168' ]; then
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show schema;" |cassandra-cli -h 10.40.246.168'  > ${datadir}/cassandra_${cnode}_${tstamp}/schema.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show keyspaces;" |cassandra-cli -h 10.40.246.168' > ${datadir}/cassandra_${cnode}_${tstamp}/keyspaces.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "describe cluster" |cassandra-cli -h 10.40.246.168' > ${datadir}/cassandra_${cnode}_${tstamp}/describe_clus.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" dsetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/dsetool_status.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_ring.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  info' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_info.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  tpstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_tpstats.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  cfstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_cfstats.lst
        fi

        if [ "${cnode}" = 'cassandra164' ]; then
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show schema;" |cassandra-cli -h 10.40.246.164'  > ${datadir}/cassandra_${cnode}_${tstamp}/schema.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "show keyspaces;" |cassandra-cli -h 10.40.246.164 ' > ${datadir}/cassandra_${cnode}_${tstamp}/keyspaces.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" echo "describe cluster" |cassandra-cli -h 10.40.246.164' > ${datadir}/cassandra_${cnode}_${tstamp}/describe_clus.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/jre1.7.0_60"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" dsetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/dsetool_status.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool status' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_ring.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  info' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_info.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  tpstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_tpstats.lst
                ssh -t ${cnode} 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle"; PATH="/usr/bin/python/:${PATH}:/usr/bin/python/" nodetool  cfstats' > ${datadir}/cassandra_${cnode}_${tstamp}/nodetool_cfstats.lst
        fi

done
tar -cvf ${datadir}/cassandra-grabs.${tstamp}.tar ${datadir}/cassandra_*_${tstamp}
gzip ${datadir}/cassandra-grabs.${tstamp}.tar
echo "cassandra info grabbed"

