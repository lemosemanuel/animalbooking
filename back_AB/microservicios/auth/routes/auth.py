from lib2to3.pgen2 import token
from flask import Blueprint, request, jsonify
from requests import get

from dataBase.pedir_relaciones import buscar_id
from function_jwt import write_token


user_auth=Blueprint("user_auth",__name__)



@user_auth.route('/auth',methods=['GET'])
def addProduct():
    respuesta=request.json
    
    print(respuesta)
    checkEmail=buscar_id('avatar_credentials','id','email', "'"+respuesta['email']+"'")
    checkPassword=buscar_id('avatar_credentials','id','password', "'"+respuesta['password']+"'")

    if checkEmail and checkPassword:
        write_token(respuesta)
        return jsonify({
            "message":"Product Added Succesfully", 
            "avatar_id":checkEmail,
            'token':str(write_token(data=respuesta))     
            })
    else:
    # new_product= {
    #     "name": request.json['name'],
    #     "price":request.json['price'],
    #     "quantity":request.json['quantity']
    # }
    # products.append(new_product)
        return jsonify({"message":"Product Added Succesfully", "products":"no existe emanuel"})
