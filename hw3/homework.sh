# List preinstalled MapReduce program examples
yarn jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar


# put README.txt it to HDFS
hdfs dfs -put ml-25m/README.txt .
hdfs dfs -ls 

# NOTE: before running this check that output directory does not exist on HDFS:
hdfs dfs -rm -r -f -skipTrash output-wordcount-mr

# Run the command:
yarn jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount README.txt output-wordcount-mr

# Check the output:
hdfs dfs -cat output-wordcount-mr/*

# TeraSort MapReduce Benchmark
# Benchmarking purpose - to test the CPU/Memory power of the cluster.
# The idea is to sort 1TB of data by the a 10 byte ascii key in the shortest amount of time possible.
# The benchmark will vary depending on available cluster resources.
# TeraGen – generating input data
# ✓ Generates random data in the following format:
# "10 bytes key | 2 bytes break | 32 bytes acsii/hex | 4 bytes break | 48 bytes filler | 4 bytes break | \r\n"
# ✓ Syntax how to run:
# yarn jar hadoop-*examples*.jar teragen <number of 100-byte rows> <output dir>
# ✓ Generating 2.5GB of data:
yarn jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar teragen -Dmapreduce.job.maps=4 25000000 terainput
hdfs dfs -ls terainput

# TeraSort – sorting generated data
# ✓ Sorts the generated data by 10 bytes ascii key in ascending order
# ✓ Syntax:
# yarn jar hadoop-*examples*.jar terasort <input dir> <output dir>
# ✓ Sorting 2.5GB of data:
yarn jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar terasort -Dmapreduce.job.reduces=1 terainput teraoutput
hdfs dfs -ls teraoutput
hdfs dfs -cat teraoutput/part-r-00000 | head -n 10
