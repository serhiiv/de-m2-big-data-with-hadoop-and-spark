# Log in to Hadoop master node via ssh
# adn set environment variable `export USER="<your name>"`

echo "$USER"

#RUN THIS UNDER hdfs USER!:
sudo su
su hdfs

# Create directory on HDFS. RUN THIS UNDER hdfs USER!:
hdfs dfs -mkdir -p /user/"$USER"

# Change ownership and permissions - note! RUN THIS UNDER hdfs USER!:
hdfs dfs -chown -R "$USER":"$USER" /user/"$USER"
hdfs dfs -chmod -R 744 /user/"$USER"
exit
exit


# ✓ Upload file to HDFS - note! RUN THIS UNDER "$USER" USER!:
hdfs dfs -put /etc/hadoop/conf/core-site.xml /user/"$USER"/

# Browse HDFS directory:
hdfs dfs -ls -h hdfs:///user/"$USER"/
hdfs dfs -ls -h /user/"$USER"/
hdfs dfs -ls -h .

# Copy directory from HDFS to local machine:
hdfs dfs -get /tmp /home/"$USER"

# Change replication factor for a file:
hdfs dfs -setrep 3 core-site.xml

# Write file with a specific block size to HDFS:
hdfs dfs -D dfs.blocksize=67108864 -put /etc/hadoop/conf/hdfs-site.xml hdfs-site.xml

# Check file statistics:
hdfs dfs -stat "%b %o %r %y" *site.xml

# Find all *-site.xml files on HDFS:
hdfs dfs -find / -name *-site.xml

# Remove files from HDFS:
hdfs dfs -rm -r -f -skipTrash *-site.xml

#############################

# Create new directory Movie_Ratings_Dataset under your home directory on HDFS (your home directory should be /user/<your user>)
hdfs dfs -mkdir -p /user/"$USER"/Movie_Ratings_Dataset

# Copy all csv files from ml-20m.zip archive to Movie_Ratings_Dataset directory on HDFS:
# copy ml-20m.zip archive from GCS storage (you can run this on master node):
gsutil cp gs://oklev-uku-datasets/movie-ratings/ml-25m.zip .

# unzip ml-20m.zip archive:
unzip ml-25m.zip

# Copy csv files from unarchived directory ml-20m to Movie_Ratings_Dataset directory on HDFS
hdfs dfs -put ml-25m/*.csv /user/"$USER"/Movie_Ratings_Dataset

# Check if /user/<your user>/Movie_Ratings_Dataset/movies.csv file exists on HDFS (use hdfs dfs–test command). 
hdfs dfs -test -e /user/"$USER"/Movie_Ratings_Dataset/movies.csv

# If the file exists then copy the file to /user/<your user>/Movie_Ratings_Dataset1 directory on HDFS
hdfs dfs -mkdir -p /user/"$USER"/Movie_Ratings_Dataset1
hdfs dfs -cp /user/"$USER"/Movie_Ratings_Dataset/movies.csv /user/"$USER"/Movie_Ratings_Dataset1

#==# Send screenshot showing output of 
hdfs dfs -ls /user/"$USER"/Movie_Ratings_Dataset*/*

# Create new directory /data/ncdc-input on HDFS
hdfs dfs -mkdir -p /data/ncdc-input

# Grant full permissions to /data/ncdc-input directory
hdfs dfs -chmod -R 744 /data/ncdc-input
hdfs dfs -chown -R "$USER":"$USER" /data/ncdc-input

# Copy *.gz files from gs://oklev-uku-datasets/ncdc to /data/ncdc-input directory on HDFS
gsutil cp gs://oklev-uku-datasets/ncdc/*.gz .
hdfs dfs -put *.gz /data/ncdc-input

# Make sure that /data/ncdc-input directory on HDFS and all the files within it have <your user>:<your user> ownership.
hdfs dfs -chmod -R 744 /data/ncdc-input
hdfs dfs -chown -R "$USER":"$USER" /data/ncdc-input

#==# Send screenshot showing output of 
hdfs dfs -ls /data/

#==# Send screenshot showing output of 
hdfs dfs -ls /data/ncdc-input/


# Allow snapshot creation for /user/<your user> directory
hdfs dfsadmin -allowSnapshot /user/"$USER"

# Create snapshot for /user/<your user> directory and name it snap1
hdfs dfs -createSnapshot /user/"$USER" snap1

# Disallow snapshotting for /user/<your user> directory
hdfs dfsadmin -disallowSnapshot /user/"$USER"

# HDFS services:
# Get hands-on experience how to check status of HDFS services
sudo su
systemctl list-units --all hadoop*

#  Try to stop and start HDFS services like namenode, datanode (use systemctl stop|start|restart <service name> for this)
systemctl restart hadoop-hdfs-secondarynamenode
systemctl list-units --all hadoop*
exit

# HDFS configuration:
#  Check what values are there for dfs.datanode.data.dir and dfs.namenode.name.dir parameters
hdfs getconf -confKey dfs.datanode.data.dir
hdfs getconf -confKey dfs.namenode.name.dir

# HDFS UIs:
# Investigate NameNode UIs. Learn what is NameNode startup process
