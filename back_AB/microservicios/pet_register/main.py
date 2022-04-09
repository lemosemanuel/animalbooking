from flask import Flask
from routes.pet_register import pet_register

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(pet_register, url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)