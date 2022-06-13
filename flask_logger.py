import datetime
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
                'remote_addr': str(request.environ.get('HTTP_X_FORWARDED_FOR')),
                'attacking_host': str(request.host),
                'access_route': str(request.access_route),
                'request_headers': str(request.headers),
                'url_params': str(request.args),
                'request_date': str(request.date),
            }
        except Exception as e:
            data = {'error': e}
        log_string = f'[{date}]\t{str(data)}\n'
        file.write(log_string)
    return jsonify(data), 200

@app.route('/xss')
def grabXss():
    with open(logfile_path, 'a+') as file:
        date = datetime.datetime.now().strftime(strf_string)
        try:
            data = {
                'remote_addr': str(request.environ.get('HTTP_X_FORWARDED_FOR')),
                'attacking_host': str(request.host),
                'access_route': str(request.access_route),
                'request_headers': str(request.headers),
                'url_params': str(request.args),
                'request_date': str(request.date),
            }
        except Exception as e:
            data = {'error': e}
        log_string = f'[{date}]\t{str(data)}\n'
        file.write(log_string)
    return jsonify(data), 200
