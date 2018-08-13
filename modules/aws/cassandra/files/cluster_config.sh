#!/bin/bash

# Configure Cassandra
NODE_IP=`hostname -I`
SEED_LIST="10.241.110.50,10.241.111.50"
CASSANDRA_YML="/etc/cassandra/conf/cassandra.yaml"
CLUSTER_NAME="cassandra_cluster"
SNITCH_TYPE="Ec2Snitch"

sed -i "/cluster_name:/c\cluster_name: \'$${CLUSTER_NAME}\'"  $${CASSANDRA_YML}
sed -i "/- seeds:/c\          - seeds: \"$${SEED_LIST}\""     $${CASSANDRA_YML}
sed -i "/listen_address:/c\listen_address: $${NODE_IP}"       $${CASSANDRA_YML}
sed -i "/rpc_address:/c\rpc_address: $${NODE_IP}"             $${CASSANDRA_YML}
sed -i "/endpoint_snitch:/c\endpoint_snitch: $${SNITCH_TYPE}" $${CASSANDRA_YML}
sed -i "/authenticator: AllowAllAuthenticator/c\authenticator: PasswordAuthenticator" $${CASSANDRA_YML}

echo 'auto_bootstrap: false' >> $${CASSANDRA_YML}

chkconfig cassandra on
service cassandra start