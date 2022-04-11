from flask import Flask
from routes.walker_reviews import walker_reviews
from routes.house_veiews import house_reviews
from routes.get_house_reviews import get_house_reviews
from routes.get_walker_reviews import get_walker_reviews

# from dotenv import load_dotenv
app = Flask(__name__)

app.register_blueprint(walker_reviews, url_prefix="/api")
app.register_blueprint(house_reviews, url_prefix="/api")
app.register_blueprint(get_house_reviews, url_prefix="/api")
app.register_blueprint(get_walker_reviews, url_prefix="/api")




if __name__ == '__main__':
    # load_dotenv()
    app.run(debug=True,port=5000)