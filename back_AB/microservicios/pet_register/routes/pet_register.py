from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


user_register=Blueprint("user_register",__name__)


@user_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

def createPet(name,age,pet_type):
    pet_type=str(buscar_id('pet_type','id','name',"'"+pet_type+"'"))
    insertData(
    'pet',
    "name,age,pet_type_id",
    "('"+name+"','"+age+"',"+pet_type+")"
    )
createPet('MARIA','7','VACA')