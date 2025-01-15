# Task3 - Acquire code for the MaxTemperature application
# Upload hadoop-examples.jar from gs://oklev-uku-datasets/applications/hadoop-examples.jar 
# to your home directory of your cluster master node
# Note: source code is here: https://github.com/elisska/hadoop-book/tree/master/ch02-mr-intro
gsutil cp gs://oklev-uku-datasets/applications/hadoop-examples.jar .


# Task 4 - Run MaxTemperature application
hdfs dfs -ls /data/ncdc-input
# Run MapReduce job on NCDC data:
yarn jar hadoop-examples.jar MaxTemperature /data/ncdc-input output-ncdc-mr
# make screenshots: run comman and count map and reduce for task

# clear output directory
hdfs dfs -rm -r -f -skipTrash output-ncdc-mr

# Note: you can also read data from GCS directly:
yarn jar hadoop-examples.jar MaxTemperature gs://oklev-uku-datasets/ncdc output-ncdc-mr
# make screenshots: run comman and count map and reduce for task


# clear output directory
hdfs dfs -rm -r -f -skipTrash output-ncdc-mr

# Task 5 - MaxTemperature application 2
# Unarchive ncdc data
# Copy unarchived data to directory on HDFS /data/ncdc-input-unarchived/
gunzip *.gz

hdfs dfs -mkdir -p /data/ncdc-input-unarchived/
hdfs dfs -chmod -R 744 /data/ncdc-input-unarchived
hdfs dfs -chown -R "$USER":"$USER" /data/ncdc-input-unarchived

hdfs dfs -put 1963 /data/ncdc-input-unarchived
hdfs dfs -put 1964 /data/ncdc-input-unarchived
hdfs dfs -put 1965 /data/ncdc-input-unarchived
hdfs dfs -put 1966 /data/ncdc-input-unarchived

hdfs dfs -ls -h /data/ncdc-input-unarchived

# Run MapReduce job on unarchived NCDC data:
yarn jar hadoop-examples.jar MaxTemperature /data/ncdc-input-unarchived output-ncdc-mr
# make screenshots: run comman and count map and reduce for task


# Question - how many mappers and reducers did MapReduce task have?
# * compare # of files and # of mappers
# * do you feel something is wrong???
# Hint: look at source files’ size

hdfs getconf -confKey dfs.blocksize

hdfs dfs -ls -h /data/ncdc-input

hdfs fsck /data/ncdc-input/1963.gz | grep "Total blocks"
hdfs fsck /data/ncdc-input/1964.gz | grep "Total blocks"
hdfs fsck /data/ncdc-input/1965.gz | grep "Total blocks"
hdfs fsck /data/ncdc-input/1966.gz | grep "Total blocks"

hdfs dfs -ls -h /data/ncdc-input-unarchived

hdfs fsck /data/ncdc-input-unarchived/1963 | grep "Total blocks"
hdfs fsck /data/ncdc-input-unarchived/1964 | grep "Total blocks"
hdfs fsck /data/ncdc-input-unarchived/1965 | grep "Total blocks"
hdfs fsck /data/ncdc-input-unarchived/1966 | grep "Total blocks"
