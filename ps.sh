#!/usr/bin/env bash
# Run this script only on ps server for distributed TensorFlow.
set -e

hosts=(dinghongquan@10.120.180.212 dinghongquan@10.120.180.213
       dinghongquan@10.120.180.214 dinghongquan@10.120.180.215)

dir=/home/dinghongquan/wide_deep_demo

echo "Start Parameter Server for Distributed TensorFlow."
nohup python wide_deep_dist.py --job_name=ps --task_index=0 >  dist.log 2>&1 &


i=0
for host in ${hosts[@]}
do
    ssh -p 1046 ${host} "cd ${dir}; nohup python wide_deep_dist.py --job_name=worker --task_index=$i > dist.log 2>&1 &"
    echo "Worker $i is ready."
	let i+=1
done

echo "All Workers are ready."