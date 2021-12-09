# Requirements

(Gatling)[https://gatling.io/open-source] need to be installed on you computer

here how to do it using command line on ubuntu

``` bash
GATLING_VERSION=3.7.2

# create directory for gatling install
mkdir -p /opt/gatling # maybe you will need sudo right here

# java dependencies
apt-get update -y && apt-get install -y wget openjdk-8-jre unzip

mkdir -p /tmp/downloads

wget -q -O /tmp/downloads/gatling-$GATLING_VERSION.zip https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip

mkdir -p /tmp/archive && cd /tmp/archive

unzip /tmp/downloads/gatling-$GATLING_VERSION.zip

mv /tmp/archive/gatling-charts-highcharts-bundle-$GATLING_VERSION/* /opt/gatling/
```

Set those env variables in your profile

``` bash
PATH=$PATH:/opt/gatling/bin
GATLING_HOME=/opt/gatling
```
