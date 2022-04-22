from flask import Flask
from routes.auth import user_auth
from routes.register import user_register
from routes.checkEmail import checkEmail
from routes.send_email import send_email
from routes.check_code import check_code
from routes.list_drop_down import list_drop_down
from routes.countries_list_drop_down import countries_list_drop_down



# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(user_auth, url_prefix="/api")
app.register_blueprint(user_register, url_prefix="/api")
app.register_blueprint(checkEmail, url_prefix="/api")
app.register_blueprint(send_email, url_prefix="/api")
app.register_blueprint(check_code, url_prefix="/api")
app.register_blueprint(list_drop_down, url_prefix="/api")
app.register_blueprint(countries_list_drop_down,url_prefix="/api")





if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=8000,host="192.168.0.166")