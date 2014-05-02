Node grabs - Grab cassandra config, logs, status.

Node stats - Grabs cassandra and os stats (e.g. tpstats iostats) every N seconds until cancel.

# Assumptions
Running on nix
A central server has passwordless access to the cassandra nodes

# Usage
List nodes in cassandra_nodes_<env>.lst
Define a directory for output
Change cassandra data path as required.

# Call:
cassandra_node_grabs.sh <env>
cassandra_stats_grabs.sh <env> <secs>

# Output:
Output is organised by servernamedate, tar'd and compressed

