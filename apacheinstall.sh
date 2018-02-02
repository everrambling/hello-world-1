#!/bin/bash
yum -y install httpd mod_ssl
systemctl enable httpd
systemctl start httpd

sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf

cat <<EOF > /var/www/html/index.html
<html>
Welcome NTI-300
</html>
EOF

