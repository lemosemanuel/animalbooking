import datetime
from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token



find_pet_by_avatar_id=Blueprint("find_pet_by_avatar_id",__name__)


def find_pet_by_owner_id(avatar_info_id):
    owner_pets_id=buscar_id("avatar_pet","pet_id","avatar_info_id",str(avatar_info_id))
    if type(owner_pets_id) == tuple:
        pets_name=buscar_id("pet","name, pet_type_id","id",owner_pets_id)
    else:
        pets_name=buscar_id("pet","name, pet_type_id","id",str(owner_pets_id))
     # json
    pets={}
    for i in range(len(pets_name)):
        try:
            print(i)
            
            pet_type_name=buscar_id('pet_type','name',"id",str(pets_name[i+1+i]))
        
        except:
            pass
        try:
            pets.update({
                i:{
                "name":pets_name[i+i],
                "pet_type":pets_name[i+1+i],
                "pet_type_name":pet_type_name
                }
            })
        except:
            pass

    return pets

# find_pet_by_owner_id("2")



@find_pet_by_avatar_id.route('/find_pet_by_avatar_id',methods=['GET'])
def find_pet_by_avatar():
    dataSended=request.json
    avatar_info_id=dataSended["avatar_info_id"]


    try:
        respuesta= find_pet_by_owner_id(avatar_info_id)
        return jsonify({
            "message":"Pets find Succesfully",
            "succefully":True,
            'pets':respuesta   
            })
    except:
        return jsonify({
            "message":"Pets not find",
            "succefully":False,
            })
