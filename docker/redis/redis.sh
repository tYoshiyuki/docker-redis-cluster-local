#!/bin/bash

rm -f \
    /data/conf/r7100i.log \
    /data/conf/r7101i.log \
    /data/conf/r7102i.log \
    /data/conf/r7103i.log \
    /data/conf/r7104i.log \
    /data/conf/r7105i.log \
    /data/conf/nodes.7100.conf \
    /data/conf/nodes.7101.conf \
    /data/conf/nodes.7102.conf \
    /data/conf/nodes.7103.conf \
    /data/conf/nodes.7104.conf \
    /data/conf/nodes.7105.conf ;

redis-server /data/conf/redis.conf --port 7100 --cluster-config-file /data/conf/nodes.7100.conf --daemonize yes ;
redis-server /data/conf/redis.conf --port 7101 --cluster-config-file /data/conf/nodes.7101.conf --daemonize yes ;
redis-server /data/conf/redis.conf --port 7102 --cluster-config-file /data/conf/nodes.7102.conf --daemonize yes ;
redis-server /data/conf/redis.conf --port 7103 --cluster-config-file /data/conf/nodes.7103.conf --daemonize yes ;
redis-server /data/conf/redis.conf --port 7104 --cluster-config-file /data/conf/nodes.7104.conf --daemonize yes ;
redis-server /data/conf/redis.conf --port 7105 --cluster-config-file /data/conf/nodes.7105.conf --daemonize yes ;

REDIS_LOAD_FLG=true;

while $REDIS_LOAD_FLG;
do
    sleep 1;
    redis-cli -p 7100 info 1> /data/conf/r7100i.log 2> /dev/null;
    if [ -s /data/conf/r7100i.log ]; then
        :
    else
        continue;
    fi
    redis-cli -p 7101 info 1> /data/conf/r7101i.log 2> /dev/null;
    if [ -s /data/conf/r7101i.log ]; then
        :
    else
        continue;
    fi
    redis-cli -p 7102 info 1> /data/conf/r7102i.log 2> /dev/null;
    if [ -s /data/conf/r7102i.log ]; then
        :
    else
        continue;
    fi
    redis-cli -p 7103 info 1> /data/conf/r7103i.log 2> /dev/null;
    if [ -s /data/conf/r7103i.log ]; then
        :
    else
        continue;
    fi
    redis-cli -p 7104 info 1> /data/conf/r7104i.log 2> /dev/null;
    if [ -s /data/conf/r7104i.log ]; then
        :
    else
        continue;
    fi
    redis-cli -p 7105 info 1> /data/conf/r7105i.log 2> /dev/null;
    if [ -s /data/conf/r7105i.log ]; then
        :
    else
        continue;
    fi
    yes "yes" | redis-cli --cluster create 127.0.0.1:7100 127.0.0.1:7101 127.0.0.1:7102 127.0.0.1:7103 127.0.0.1:7104 127.0.0.1:7105 --cluster-replicas 1;
    REDIS_LOAD_FLG=false;
done

exit 0;
