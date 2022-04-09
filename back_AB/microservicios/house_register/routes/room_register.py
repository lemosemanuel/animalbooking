from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


room_register=Blueprint("room_register",__name__)





def createTypeOfRoom(name,price,pet_type_id):
    pet_type_id=str(buscar_id('pet_type','id','name',"'"+pet_type_id+"'"))

    id_room_insert=insertData(
        'type_of_room',
        """
            name, price, pet_type_id
        """,
        "('"+name+"','"+price+"',"+pet_type_id+")"
        )
    # print(' la habitacion fue creada con el id :'+id_room_insert)
    return id_room_insert

def type_of_room_services(id_room,services):
    # inserto los servicios
    for servicios in services:
        servicios=str(buscar_id('room_services','id','name',"'"+servicios+"'"))
        print("el servicio es: "+ servicios)
        print("el id es: "+ id_room)

        insertData(
            'type_of_room_room_services',
            """
                type_of_room_id,room_services_id
            """,
            "("+id_room+","+servicios+")"
            )    
        # print(' el servicio fue creado con el id :'+id_service)




@room_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@room_register.route('/room_register',methods=['GET'])
def createRoom():
    dataSended=request.json
    name = dataSended['name'] 
    price = dataSended['price'] 
    services = dataSended['service'] 
    pet_type_id = dataSended['pet_type_id']

    try:
        id_room=createTypeOfRoom(
            name,
            price,
            pet_type_id
            )
        type_of_room_services(str(id_room),services)
        return jsonify({"message":"Avatar Added Succesfully", "products":"CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

