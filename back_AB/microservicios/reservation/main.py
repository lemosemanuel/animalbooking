from flask import Flask
from routes.reservation import reservation
from routes.free_reservations_days import checkFreeBeds


# from dotenv import load_dotenv
app = Flask(__name__)
app.register_blueprint(checkFreeBeds, url_prefix="/api")

app.register_blueprint(reservation, url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)