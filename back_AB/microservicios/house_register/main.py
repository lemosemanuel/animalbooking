from flask import Flask
from routes.house_register import house_register
from routes.room_register import room_register

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(house_register, url_prefix="/api")
app.register_blueprint(room_register, url_prefix="/api")




if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)