# service start
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do sudo service $x stop ; done
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do sudo service $x start ; done

# init hdfs
sudo /usr/lib/hadoop/libexec/init-hdfs.sh
sudo -u hdfs hadoop fs -ls -R /

# start yarn
sudo service hadoop-yarn-resourcemanager start
sudo service hadoop-yarn-nodemanager start
sudo service hadoop-mapreduce-historyserver start

