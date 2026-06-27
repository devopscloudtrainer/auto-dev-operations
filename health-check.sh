#!/bin/bash
pid=`ps -ef | grep -i httpd | grep -v grep | awk 'NR==1 { print $2 }' | wc -l`

static_web_page () {
 if [ -f /var/www/html/index.html ];
 then
   echo "Index.html is available for launching the static web page"
 else
   echo "Index.html is not available for launching the static web page"
   echo "Adding index.html page in /var/www/html location"
   cp -r /tmp/index.html /var/www/html/index.html
   echo "Added index.html page in /var/www/html location"
 fi
}

if [ $pid == 1 ];
then
  echo "HTTPD service is running"
  echo "Verify Index.html is available in /var/www/html location? "
  static_web_page
  echo "Verification is completed for running httpd service"
else
  echo "HTTPD service is down"
  echo "Restarting HTTPD service"
  systemctl restart httpd
  echo "HTTPD service started"
  echo "Verify Index.html is available in /var/www/html location? "
  static_web_page
  echo "Verification is completed post httpd service restart"
fi


