import datetime
import json
import os
from flask import Flask
from flask import request
from flask import jsonify

# globals
app = Flask(__name__)
dir_path = os.path.dirname(os.path.realpath(__file__))
logfile_path = dir_path + '/flasklogger_access.log'
strf_string = '%d.%m.%Y - %H:%M:%S'

@app.route('/')
def grab():
    with open(logfile_path, 'a+') as file:
        date = datetime.datetime.now().strftime(strf_string)
        try:
            data = {
                'timestamp': date,
                'remote_addr': str(request.environ.get('HTTP_X_FORWARDED_FOR')),
                'attacking_host': str(request.host),
                'access_route': [x for x in request.access_route],
                'request_headers': [x for x in request.headers],
                'url_params': [x for x in request.args]
            }
            request.headers
        except Exception as e:
            data = {'error': e}
        log_string = json.dumps(data)
        file.write(log_string + '\n')
    return jsonify(data), 200

@app.route('/xss')
def grabXss():
    with open(logfile_path, 'a+') as file:
        date = datetime.datetime.now().strftime(strf_string)
        try:
            data = {
                'timestamp': date,
                'remote_addr': str(request.environ.get('HTTP_X_FORWARDED_FOR')),
                'attacking_host': str(request.host),
                'access_route': [x for x in request.access_route],
                'request_headers': [x for x in request.headers],
                'url_params': [x for x in request.args]
            }
        except Exception as e:
            data = {'error': e}
        log_string = json.dumps(data)
        file.write(log_string + '\n')
    return jsonify(data), 200
