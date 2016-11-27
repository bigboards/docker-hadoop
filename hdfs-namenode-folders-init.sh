#!/bin/bash
sleep 10
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop dfsadmin -safemode wait
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop dfs -mkdir -p "/tmp" "/user/root" "/user/bb"
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop dfs -chown -R root:supergroup "/tmp" "/user"
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop dfs -chown -R bb:bigboards "/tmp" "/user/bb"
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop dfs -chmod -R 777 "/tmp"
