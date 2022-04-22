from flask import Blueprint, request, jsonify

from dataBase.pedir_relaciones import buscar_id
from function_jwt import write_token


checkEmail=Blueprint("checkEmail",__name__)



@checkEmail.route('/checkEmail',methods=['GET'])
def checkMail():
    respuesta=request.json
    
    print(respuesta)
    # print("la respuesta es :" +respuesta['email'])
    checkEmail=buscar_id('avatar_credentials','id','email', "'"+respuesta['email']+"'")

    if checkEmail:
        write_token(respuesta)
        return jsonify({
            "succefully":True,
            })
    else:
        return jsonify({"succefully":False})
