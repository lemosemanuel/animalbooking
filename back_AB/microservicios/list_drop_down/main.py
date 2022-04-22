from flask import Flask
from routes.list_drop_down import list_drop_down
from routes.countries_list_drop_down import countries_list_drop_down
# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(list_drop_down, url_prefix="/api")
app.register_blueprint(countries_list_drop_down,url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=8000,host="192.168.1.135")