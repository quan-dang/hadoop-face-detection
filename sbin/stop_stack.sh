#!/bin/sh

# start Hadoop
echo "[INFO] Starting Hadoop"
cd $HADOOP_HOME
sbin/stop-dfs.sh