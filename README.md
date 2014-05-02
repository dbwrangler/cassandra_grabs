Node grabs - Grab cassandra config, logs, status. <br />
Node stats - Grabs cassandra and os stats (e.g. tpstats iostats) every N seconds until cancel.

## Assumptions
Running on nix <br />
A central server has passwordless access to the cassandra nodes

## Usage
List nodes in cassandra_nodes_\<env\>.lst <br />
Define a directory for output <br />
Change cassandra data path as required.

## Call:
cassandra_node_grabs.sh \<env\> <br />
cassandra_stats_grabs.sh \<env\> \<secs\> <br />

## Output:
Output is organised by servernamedate, tar'd and compressed

