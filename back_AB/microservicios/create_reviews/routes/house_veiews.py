from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from function_jwt import validate_token


house_reviews=Blueprint("house_reviews",__name__)


def creteReviews(description,calification,avatar_info_id):
    reviews_id=insertData(
            'reviews',
            """
                description,calification,avatar_info_id
            """,
            "('"+description+"','"+calification+"',"+avatar_info_id+")"
            )
    return reviews_id


def createReviewsHouse(house_info_id,reviews_id):
    insertData(
            'house_info_reviews',
            """
                house_info_id, reviews_id
            """,
            "("+str(house_info_id)+","+str(reviews_id)+")"
            )


@house_reviews.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@house_reviews.route('/house_reviews',methods=['GET'])
def createRoom():
    dataSended=request.json
    house_info_id = dataSended['house_info_id'] 
    description = dataSended['description'] 
    calification = dataSended['calification'] 
    avatar_info_id= dataSended['avatar_info_id']
    try:
        reviews_id=creteReviews(
            description,
            calification,
            avatar_info_id
        )
        # print(reviews_id)
        createReviewsHouse(
            house_info_id,
            reviews_id
        )
        return jsonify({"message":"Avatar Added Succesfully", "products":"CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

