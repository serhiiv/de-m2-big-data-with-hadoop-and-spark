# Log in to Hadoop master node via ssh
# use environment variable for your user name "$USER"
echo "$USER"

#RUN THIS UNDER hdfs USER!:
sudo su
su hdfs

# Create directory on HDFS.
hdfs dfs -mkdir -p /user/"$USER"

# Change ownership and permissions - note!
hdfs dfs -chown -R "$USER":"$USER" /user/"$USER"
hdfs dfs -chmod -R 744 /user/"$USER"
exit
exit

# Create new directory Movie_Ratings_Dataset under your home directory on HDFS (your home directory should be /user/<your user>)
hdfs dfs -mkdir -p /user/"$USER"/Movie_Ratings_Dataset

# Copy all csv files from ml-20m.zip archive to Movie_Ratings_Dataset directory on HDFS:

# copy ml-20m.zip archive from GCS storage (you can run this on master node):
gsutil cp gs://oklev-uku-datasets/movie-ratings/ml-25m.zip .

# unzip ml-20m.zip archive:
unzip ml-25m.zip

# Copy csv files from unarchived directory ml-20m to Movie_Ratings_Dataset directory on HDFS
hdfs dfs -put ml-25m/*.csv /user/"$USER"/Movie_Ratings_Dataset

# copy movies.csv to /user/<your user>/Movie_Ratings_Dataset1 directory on HDFS
hdfs dfs -mkdir -p /user/"$USER"/Movie_Ratings_Dataset1
hdfs dfs -cp /user/"$USER"/Movie_Ratings_Dataset/movies.csv /user/"$USER"/Movie_Ratings_Dataset1

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

# Allow snapshot creation for /user/<your user> directory
hdfs dfsadmin -allowSnapshot /user/"$USER"

# Create snapshot for /user/<your user> directory and name it snap1
hdfs dfs -createSnapshot /user/"$USER" snap1

# Disallow snapshotting for /user/<your user> directory
hdfs dfsadmin -disallowSnapshot /user/"$USER"
