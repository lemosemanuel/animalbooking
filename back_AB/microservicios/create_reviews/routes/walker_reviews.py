from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from function_jwt import validate_token


walker_reviews=Blueprint("walker_reviews",__name__)


def creteReviews(description,calification,avatar_info_id):
    reviews_id=insertData(
            'reviews',
            """
                description,calification,avatar_info_id
            """,
            "('"+description+"','"+calification+"',"+avatar_info_id+")"
            )
    return reviews_id

def createReviewsWalker(walker_info_id,reviews_id):
    insertData(
            'walker_info_reviews',
            """
                walker_info_id, reviews_id
            """,
            "("+str(walker_info_id)+","+str(reviews_id)+")"
            )


@walker_reviews.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@walker_reviews.route('/walker_reviews',methods=['GET'])
def createRoom():
    dataSended=request.json
    walker_info_id = dataSended['walker_info_id'] 
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
        createReviewsWalker(
            walker_info_id,
            reviews_id
        )
        return jsonify({"message":"Avatar Added Succesfully", "products":"CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

