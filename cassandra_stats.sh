#!/bin/bash
echo "cassandra.WriteLatency `nodetool cfstats system | grep "Write Latency" | awk '{print $(NF-1)}'` `date +%s`" | nc -q0 127.0.0.1 2003
echo "cassandra.WriteCount `nodetool cfstats system | grep "Write Count" | awk '{print $(NF-1)}'` `date +%s`" | nc -q0 127.0.0.1 2003
echo "cassandra.ReadLatency `nodetool cfstats system | grep "Read Latency" | awk '{print $(NF-1)}'` `date +%s`" | nc -q0 127.0.0.1 2003
echo "cassandra.ReadCount `nodetool cfstats system | grep "Read Count" | awk '{print $(NF-1)}'` `date +%s`" | nc -q0 127.0.0.1 2003
echo "cassandra.HeapMemory `nodetool cassandra info | grep "^Heap Memory" | awk '{print $(NF-2)}'` `date +%s`" | nc -q0 127.0.0.1 2003
echo "cassandra.Load `nodetool status | grep "127.0.0.1" | awk '{print $3}'` `date +%s`" | nc -q0 127.0.0.1 2003
nodetool tpstats | head -21 | tail -20 | awk '{print "cassandra.ThreadPool."$1,$4}' | while read i
do
sleep 2
echo "$i `date +%s`" | nc -q0 127.0.0.1 2003
done
