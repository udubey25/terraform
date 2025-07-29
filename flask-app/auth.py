from flask import Blueprint, redirect, url_for, session
from authlib.integrations.flask_client import OAuth

oauth = OAuth()
auth_bp = Blueprint('auth', __name__)


@auth_bp.route('/login')

def login():
  google = oauth.create_client('google')
  redirect_uri = url_for('auth.callback', _external=True)
  return google.authorize_redirect(redirect_uri)

@auth_bp.route('/callback')
def callback():
  google = oauth.create_client('google')
  token = google.authorize_access_token()
  user_info = google.parse_id_token(token)
  session['user'] = user_info
  return redirect('/dashboard')

@auth_bp.route('/logout')
def logout():
  session.pop('user', None)
  return redirect('/')