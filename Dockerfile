FROM bigboards/java-7-__arch__

MAINTAINER bigboards (hello@bigboards.io)

# python
RUN apt-get update && apt-get install -y -q \
    libxml-xpath-perl \
    python \
    build-essential \ 
    gfortran \
    libatlas-base-dev \
    python-pip \
    python-dev

# hadoop
RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz | tar -xz -C /opt
RUN cd /opt && ln -s ./hadoop-2.6.4 hadoop

# Hive
RUN curl -s http://archive.apache.org/dist/hive/hive-2.3.2/apache-hive-2.3.2-bin.tar.gz | tar -xz -C /opt
# RUN curl -s https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O /opt/apache-hive-2.3.2-bin/lib/postgresql-jdbc.jar
RUN cd /opt && ln -s ./apache-hive-2.3.2-bin hive

ENV HADOOP_PREFIX /opt/hadoop
ENV YARN_HOME /opt/hadoop
ENV HADOOP_YARN_HOME /opt/hadoop
ENV HADOOP_HDFS_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HDFS_CONF_DIR /opt/hadoop/etc/hadoop
ENV YARN_CONF_DIR /opt/hadoop/etc/hadoop
ENV HIVE_CONF_DIR /opt/hive/conf
ENV HIVE_HOME /opt/hive

# copy the format script
ADD hdfs-namenode-wrapper.sh /opt/hadoop/bin/hdfs-namenode-wrapper.sh
RUN chmod u+x /opt/hadoop/bin/hdfs-namenode-wrapper.sh
ADD hadoop-shell /bin/hadoop-shell
RUN chmod a+x /bin/hadoop-shell

RUN apt-get update \
    && apt-get install -y build-essential gfortran libatlas-base-dev python-pip python-dev pkg-config libpng-dev libjpeg8-dev libfreetype6-dev \
    && yes | pip install --upgrade pip numpy scipy pandas scikit-learn matplotlib sparkts

#          namenode              datanode                resourcemanager       nodemanager
#       +--------------+ +-------------------------+ +----------------------+ +------------+
#EXPOSE 8020 50070 50470 50010 1004 50075 1006 50020 8030 8031 8032 8033 8088 8040 8041 8042

CMD ["/bin/bash"]
