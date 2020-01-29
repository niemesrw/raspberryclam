#!/bin/sh


sudo adduser --home /opt/splunkforwarder --disabled-login splunk --gecos splunk
sudo usermod -G adm splunk

wget -O splunkforwarder-8.0.1-6db836e2fb9e-Linux-arm.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=ARM&platform=linux&version=8.0.1&product=universalforwarder&filename=splunkforwarder-8.0.1-6db836e2fb9e-Linux-arm.tgz&wget=true'

gzip -cd splunkforwarder*.tgz | tar xvf - -C /opt

chown -R splunk:splunk /opt/splunkforwarder

sudo -u splunk /opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt --gen-and-print-passwd

/opt/splunkforwarder/bin/splunk enable boot-start

sudo -u splunk /opt/splunkforwarder/bin/splunk stop
sudo -u splunk /opt/splunkforwarder/bin/splunk set deploy-poll ds.illumina.com:8089
sudo -u splunk /opt/splunkforwarder/bin/splunk start
