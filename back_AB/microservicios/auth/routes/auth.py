from flask import Blueprint, request, jsonify

from dataBase.pedir_relaciones import buscar_id
from function_jwt import write_token


user_auth=Blueprint("user_auth",__name__)



@user_auth.route('/auth',methods=['GET'])
def auth():
    respuesta=request.json
    
    print(respuesta)
    # print("la respuesta es :" +respuesta['email'])
    checkEmail=buscar_id('avatar_credentials','avatar_info_id','email', "'"+respuesta['email']+"'")
    checkPassword=buscar_id('avatar_credentials','id','password', "'"+respuesta['password']+"'")
    nameAvatar=buscar_id('avatar_info','name','id', ""+str(checkEmail)+"")

    if checkEmail and checkPassword:
        jsonData=write_token(
                data={
                    "name":nameAvatar,
                    "id":respuesta['password'],
                    "avatar_type":['normal','walker','hoster'],
                    }
                    )
        return jsonify({
            "message":"User Login Succesfully",
            "succefully":True,
            "avatar_id":checkEmail,
            'token':str(jsonData)     
            })
    else:
        return jsonify({"succefully":False})
