from flask import Flask
from routes.images import images
# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(images, url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)