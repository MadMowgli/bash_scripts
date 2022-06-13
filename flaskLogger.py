import datetime
import os
from flask import Flask
from flask import request
from flask import jsonify

# globals
app = Flask(__name__)
dir_path = os.path.dirname(os.path.realpath(__file__))
logfile_path = dir_path + 'flasklogger_access.log'
strf_string = '%d.%m.%Y - %H:%M:%S'

@app.route('/')
def grab():
    with open(logfile_path, 'a+') as file:
        date = datetime.datetime.now().strftime(strf_string)
        try:
            data = {
                'remote_addr': request.remote_addr,
                'parsed_proxy_addr': request.environ.get('HTTP_X_FORWARDED_FOR'),
                'host': request.host,
                'access_route': request.access_route,
                'request_headers': request.headers,
                'url_params': request.args,
                'request_date': request.date,
            }
        except Exception as e:
            data = {'error': e}
        log_string = f'[{date}]\t{str(data)}\n'
        file.write(log_string)
    return jsonify(data), 200