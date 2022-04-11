from flask import Flask
from routes.walker_register import walker_register

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(walker_register, url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)