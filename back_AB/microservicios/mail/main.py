from flask import Flask
from routes.send_email import send_email
from routes.check_code import check_code

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(send_email, url_prefix="/api")
app.register_blueprint(check_code, url_prefix="/api")




if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)