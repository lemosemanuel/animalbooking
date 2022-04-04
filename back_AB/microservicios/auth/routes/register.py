from flask import Blueprint, request, jsonify

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


user_register=Blueprint("user_register",__name__)

@user_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)


@user_register.route('/register',methods=['GET'])
def addProduct():
    dataSended=request.json
    
    # chequeo que el mail no exista
    checkEmail=buscar_id('avatar_credentials','id','email', "'"+dataSended['email']+"'")
    if checkEmail:
        return jsonify({"message":"Product Added Succesfully", "products":"No se puede registrar un Mail que YA EXISTE"})
    else:
    # new_product= {
    #     "name": request.json['name'],
    #     "price":request.json['price'],
    #     "quantity":request.json['quantity']
    # }
    # products.append(new_product)
        return jsonify({"message":"Product Added Succesfully", "products":"no existe emanuel"})
