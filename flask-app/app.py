from flask import Flask, render_template, request, redirect, session, jsonify
from auth import auth_bp, oauth
import os, string, random

app = Flask(__name__)
app.secret_key = os.urandom(24)

# Register OAuth
app.register_blueprint(auth_bp)
oauth.init_app(app)
oauth.register(
    name='google',
    client_id='YOUR_CLIENT_ID',
    client_secret='YOUR_CLIENT_SECRET',
    access_token_url='https://oauth2.googleapis.com/token',
    authorize_url='https://accounts.google.com/o/oauth2/v2/auth',
    api_base_url='https://openidconnect.googleapis.com/v1/',
    client_kwargs={'scope': 'openid email profile'},
)

url_db = {}

def generate_code(length=6):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/shorten', methods=['POST'])
def shorten():
    data = request.form
    long_url = data.get('long_url')
    if not long_url:
        return "Missing URL", 400
    code = generate_code()
    url_db[code] = long_url
    return render_template('index.html', short_url=f"/{code}")

@app.route('/dashboard')
def dashboard():
    if 'user' not in session:
        return redirect('/login')
    return render_template('dashboard.html', urls=url_db)

@app.route('/<code>')
def redirect_url(code):
    long_url = url_db.get(code)
    if not long_url:
        return "URL not found", 404
    return redirect(long_url)

if __name__=='__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
