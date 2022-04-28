from flask import Flask
from routes.get_data_host_from_id import data_particular_house
# from routes.reservation import reservation
from routes.find_booking import find_space
from routes.get_resume_host_list import resume_data_house



# from dotenv import load_dotenv
app = Flask(__name__)
# app.register_blueprint(checkFreeBeds, url_prefix="/api")
app.register_blueprint(find_space, url_prefix="/api")
app.register_blueprint(data_particular_house, url_prefix="/api")
app.register_blueprint(resume_data_house, url_prefix="/api")




# app.register_blueprint(reservation, url_prefix="/api")



if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=8000,host="192.168.1.243")