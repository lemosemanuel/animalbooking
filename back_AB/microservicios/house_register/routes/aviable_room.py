from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


aviable_room=Blueprint("aviable_room",__name__)

def createRoomAviable(house_info_id,start_day, end_day, num_of_pet, pet_type_id, active, type_of_room_id):
    pet_type_id=str(buscar_id('pet_type','id','name',"'"+pet_type_id+"'"))

    id_insert=insertData(
        'room_aviable',
        """
            house_info_id,start_day, end_day, num_of_pet, pet_type_id, active, type_of_room_id
        """,
        "("+house_info_id+",'"+start_day+"','"+end_day+"',"+num_of_pet+","+pet_type_id+",'"+active+"',"+type_of_room_id+")"
        )

    
    print(id_insert)





@aviable_room.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@aviable_room.route('/aviable_room',methods=['GET'])
def createDateOfAviableRoom():
    dataSended=request.json
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    num_of_pet=dataSended['num_of_pet']
    pet_type_id=dataSended['pet_type_id']
    active=dataSended['active']
    type_of_room_id=dataSended['type_of_room_id']
    house_info_id=dataSended['house_info_id']

    try:
        createRoomAviable(
            house_info_id,
            start_day,
            end_day,
            num_of_pet,
            pet_type_id,
            active,
            type_of_room_id
            
            )
        return jsonify({"message":"Avatar Added Succesfully", "products":"Se puso fechas habilitadas de inicio de la habitacion"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

