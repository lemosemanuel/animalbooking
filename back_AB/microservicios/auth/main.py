from flask import Flask
from routes.auth import user_auth
from routes.register import user_register
from routes.checkEmail import checkEmail

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(user_auth, url_prefix="/api")
app.register_blueprint(user_register, url_prefix="/api")
app.register_blueprint(checkEmail, url_prefix="/api")




if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=8000,host="192.168.1.135")