from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id



check_code=Blueprint("check_code",__name__)



@check_code.route('/check_code',methods=['GET'])
def checkCode():
    """Json that i want to resive
    {
        'avatar_info_id':
        'secure_code':
    }
    
    """
    respuesta=request.json
    # me envia el codigo y el id de la persona
    # print(respuesta['avatar_info_id'])
    # print(respuesta['secure_code'])


    secure_code=buscar_id('avatar_credentials','secure_code','avatar_info_id',"'"+respuesta['avatar_info_id']+"'")
    if len(secure_code)>1:
        secure_code=buscar_id('avatar_credentials','secure_code','avatar_info_id',"'"+respuesta['avatar_info_id']+"'")[0]
    # print(secure_code)
    if str(secure_code) == respuesta['secure_code']:
            return jsonify({"message":"Code created Succesfully", "products":'el codigo es correcto'})
    else:
        return jsonify({"message":"Code created Succesfully", "products":'No hay mach'})

