
from flask 
app = Flask(__name__, static_folder='static')

@app.route('/')
def serve_static(filename):
    return send_from_directory(app.static_folder, filename)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
