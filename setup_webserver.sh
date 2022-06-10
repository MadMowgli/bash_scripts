#/usr/bin/bash
# ----------------------------------------------------------------------------
# -------------- PYTHON FLASK & NGINX SIMPLE WEB SERVER SETUP 	--------------
# -------------- 		REPLACE THE PUBLIC SERVER IP!!!			--------------
# ----------------------------------------------------------------------------

# install prerequisites
sudo apt update
sudo apt install python3 -Y
sudo apt install python3-pip -Y
sudo apt install nginx -Y
sudo apt install gunicorn -Y
pip3 install flask

# create directory
mkdir flask_webserver
cd flask_webserver

# write python file
printf "from flask import Flask" >> webserver.py
printf "\n" >> webserver.py
printf "app = Flask(__name__)" >> webserver.py
printf "\n" >> webserver.py
printf "@app.route('/')" >> webserver.py
printf "\n" >> webserver.py
printf "def hello_world():" >> webserver.py
printf "\n" >> webserver.py
printf "    return '<p>Hello, World!</p>'" >> webserver.py

# write nginx config file - REPLACE THE PUBLIC SERVER IP!!!
printf "server {\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "    listen 80;\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "    server_name 172.105.251.133;" >> /etc/nginx/sites-enabled/flask_webserver
printf "\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "    location / {\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "        proxy_pass http://127.0.0.1:8000;\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "        proxy_set_header Host \$host;\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "    }\n" >> /etc/nginx/sites-enabled/flask_webserver
printf "}\n" >> /etc/nginx/sites-enabled/flask_webserver

# Unlink the default config file and reload nginx to use the newly created config file.
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -s reload

# start webserver: 	cd flask_webserver && gunicorn -w 3 webserver:app
# reset: 			rm -r flask_webserver
#					rm /etc/nginx/sites-enabled/flask_webserver
#					rm setup_webserver.sh
