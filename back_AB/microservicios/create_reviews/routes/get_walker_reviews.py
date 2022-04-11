from flask import Blueprint, current_app, request, jsonify
from dataBase.insertarDatos import insertData
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


get_walker_reviews=Blueprint("get_walker_reviews",__name__)

def get_reviews_walker(house_info_id): 
    house_id=buscar_id('walker_info_reviews','reviews_id','walker_info_id',house_info_id)
    print(len(house_id))
    if len(house_id)>1:
        comment= buscar_id('reviews','description,avatar_info_id','id',house_id)
    else:
        comment= buscar_id('reviews','description,avatar_info_id','id',str(house_id))
    
    lista=[]
    tupla=[]
    count=0

    for i in comment:
        tupla.append(i)
        count=count+1
        if count == 2:
                lista.append(tuple(tupla))
                tupla=[]
                count=0
    
    return lista


@get_walker_reviews.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@get_walker_reviews.route('/get_walker_reviews',methods=['GET'])
def get_walker_rev():
    dataSended=request.json
    house_info_id = dataSended['house_info_id'] 
    try:
        lista=get_reviews_walker(
            house_info_id
        )
        return jsonify({"message":"Avatar Added Succesfully", "products":lista})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})
