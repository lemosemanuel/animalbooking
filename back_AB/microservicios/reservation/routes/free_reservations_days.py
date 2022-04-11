import datetime
from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


checkFreeBeds=Blueprint("checkFreeBeds",__name__)

def checkFreeReservation(type_of_room_id,pet_id):
    print(buscar_id('room_aviable','start_day','type_of_room_id',type_of_room_id))
    print(buscar_id('room_aviable','end_day','type_of_room_id',type_of_room_id))
    start_day_aviable=buscar_id('room_aviable','start_day','type_of_room_id',type_of_room_id)
    end_day_aviable=buscar_id('room_aviable','end_day','type_of_room_id',type_of_room_id)

    id_pet_permite=buscar_id('room_aviable','pet_type_id','type_of_room_id',type_of_room_id)
    id_pet_want=buscar_id('pet_type','id','name',"'"+pet_id+"'")
            
    if id_pet_permite == id_pet_want:
        print('permitido')

        # hago la lista de todos los dias que se quiere quedar
        listaDiasReservados=[]
        for i in range(len(buscar_id('reservations','start_day','type_of_room_id',type_of_room_id))):
            # dias que entra
            tiempoDeLaEstadia=buscar_id('reservations','end_day','type_of_room_id',type_of_room_id)[i]-buscar_id('reservations','start_day','type_of_room_id',type_of_room_id)[i]
            tiempoDeLaEstadia
            

            for e in range(tiempoDeLaEstadia.days):
                dias=buscar_id('reservations','start_day','type_of_room_id',type_of_room_id)[i]+datetime.timedelta(days=e)                    
                listaDiasReservados.append(dias)
        # print(listaDiasReservados)
        # print(start_day_aviable)
        date_generated = [start_day_aviable + datetime.timedelta(days=x) for x in range(0, (end_day_aviable-start_day_aviable).days)]
        # print(date_generated)
        freeSpaces = (set(date_generated) - set(listaDiasReservados))
        # print('------------------------------')
        # print(c)
        return freeSpaces

    else:
        print('no se puede esa especie de animal')


# checkFreeReservation('1','PERRO')




@checkFreeBeds.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@checkFreeBeds.route('/checkFreeBeds',methods=['GET'])
def checkFreeBed():
    dataSended=request.json
    type_of_room_id=dataSended['type_of_room_id']
    pet_id=dataSended['pet_id']
    try:
        freeSpaces=checkFreeReservation(
            type_of_room_id,pet_id            
            )
        return jsonify({"message":"Avatar Added Succesfully", "products":str(freeSpaces)})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

