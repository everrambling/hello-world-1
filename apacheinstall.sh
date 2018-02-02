#!/bin/bash

if [ -e /var/www/html/index.html ]; then
exit 0;
fi

yum -y install httpd mod_ssl
systemctl enable httpd
systemctl start httpd

sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf

cat <<EOF > /var/www/html/index.html
<html>
Welcome NTI-300
</html>
EOF

cat <<EOF > /var/cron/crontab/root

# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday to Saturday;
# │ │ │ │ │                                       7 is also Sunday on some systems)
# │ │ │ │ │
# │ │ │ │ │
# * * * * *  command to execute
18,0 * * * * /usr/bin/echo "hello world"
30 * * * * /home/nicolebade/hello-nti-300/automated_webpage.sh
EOF



cat <<EOF > /home/nicolebade/hello-nti-300/automated_webpage.sh
#!/bin/bash
echo -e "<html> \n <h1> Welcome, NTI-300 </h1> \n<h2> Yay, I'm having so much fun with linux</h2> \n <p> this is the date right now: $(date +c)</p> \n</html>" > /var/www/html/index.html
EOF

