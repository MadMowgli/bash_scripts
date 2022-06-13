#/usr/bin/bash
# ----------------------------------------------------------------------------
# -------------- PYTHON FLASK & NGINX SIMPLE WEB SERVER SETUP 	--------------
# -------------- 		REPLACE THE PUBLIC SERVER IP!!!			--------------
# ----------------------------------------------------------------------------

# install prerequisites
sudo apt update
sudo apt install python3
sudo apt install python3-pip
sudo apt install nginx
sudo apt install gunicorn
pip3 install flask

# create directory
mkdir flask_webLogger
cd flask_webLogger

# write python file
wget 'https://raw.githubusercontent.com/MadMowgli/webSec_scripts/main/flask_logger.py'

# write nginx config file - REPLACE THE PUBLIC SERVER IP!!!
printf "server {\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "    listen 80;\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "    server_name 172.105.251.133;\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "    location / {\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "        proxy_pass http://127.0.0.1:8000;\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "        proxy_set_header Host \$host;\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "    }\n" >> /etc/nginx/sites-enabled/flask_webLogger
printf "}\n" >> /etc/nginx/sites-enabled/flask_webLogger

# Unlink the default config file and reload nginx to use the newly created config file.
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -s reload

# start webserver: 	cd flask_webLogger && gunicorn -w 3 flask_logger:app
# reset: 			rm -r flask_webLogger
#					rm /etc/nginx/sites-enabled/flask_webLogger
#					rm setup_webserver.sh
