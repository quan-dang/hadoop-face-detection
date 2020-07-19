#!/bin/sh

# grab the current working dir
BASE=$(pwd)

# create the latest deployable .zip file
sbin/deploy.sh

# change the dir to where hadoop live
cd $HADOOP_HOME

# turn off safe mode
bin/hdfs dfsadmin -safemode leave

# remove the previous output dir
bin/hdfs dfs -rm -r /user/quandv/faces/output

# define set of local files need to present to run the hadoop
# job -- comma seperate each_file_path
FILES="${BASE}/face_detector_mapper.py,\
${BASE}/deploy/pyimagesearch.zip,\
${BASE}/cascades/haarcascade_frontalface_default.xml"

# run the job on Hadoop
bin/hadoop jar share/hadoop/tools/lib/hadoop-streaming-*.jar \
    -D mapreduce.job.reduces=0 \
    -files ${FILES} \
    -mapper ${BASE}/face_detector_mapper.py \
    -input /user/quandv/faces/input/faces_dataset.txt \
    -output /user/quandv/faces/output