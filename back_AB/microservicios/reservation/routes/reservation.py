import datetime
from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


reservation=Blueprint("reservation",__name__)

def createReservation(type_of_room_id,avatar_info_id,pet_id,start_day,end_day,status):
    print(buscar_id('room_aviable','start_day','type_of_room_id',type_of_room_id))
    print(buscar_id('room_aviable','end_day','type_of_room_id',type_of_room_id))
    start_day_aviable=buscar_id('room_aviable','start_day','type_of_room_id',type_of_room_id)
    end_day_aviable=buscar_id('room_aviable','end_day','type_of_room_id',type_of_room_id)
    start_day_aviable=datetime.datetime.strptime(start_day_aviable,'%Y-%m-%d').date()
    end_day_aviable=datetime.datetime.strptime(end_day_aviable,'%Y-%m-%d').date()
    print(start_day_aviable)
    print(end_day_aviable)
    # primero me fijo si esta dentro de lo habilitado por el lugar
    if start_day_aviable <= start_day and end_day_aviable >= start_day:
        if start_day_aviable <= end_day and end_day_aviable >= end_day:
            print('esta dentro de lo habilitado')
            
            # hago la lista de todos los dias que se quiere quedar
            listaDiasAReservar=[]
            cantDias= end_day - start_day
            for i in range(cantDias):
                listaDiasAReservar.append(start_day+datetime.timedelta(days=i))

            # ahora me fijo las reservas que tiene
            # hago la lista de los dias reservados
            listaDiasReservados=[]
            for i in range(len(buscar_id('reservations','start_day','type_of_room_id',type_of_room_id))):
                # dias que entra
                tiempoDeLaEstadia=buscar_id('reservations','end_day','type_of_room_id',type_of_room_id)[i]-buscar_id('reservations','start_day','type_of_room_id',type_of_room_id)[i]
                tiempoDeLaEstadia
                

                for e in range(tiempoDeLaEstadia.days):
                    dias=buscar_id('reservations','start_day','type_of_room_id',type_of_room_id)[i]+datetime.timedelta(days=e)
                    
                    listaDiasReservados.append(dias)

                    if listaDiasAReservar in listaDiasReservados:
                        print('se puede')

createReservation('1','3','3',datetime.date(2022, 4, 23),datetime.date(2022, 4, 24),'se')


    # ya tengo los dias reservados del lugar
    # ahora los inserto en las reservas

    id_insert=insertData(
        'room_aviable',
        """
            type_of_room_id,avatar_info_id,pet_id,start_day,end_day,status
        """,
        "("+house_info_id+",'"+start_day+"','"+end_day+"',"+num_of_pet+","+pet_type_id+",'"+active+"',"+type_of_room_id+")"
        )

    
    print(id_insert)





@reservation.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@reservation.route('/aviable_room',methods=['GET'])
def createNewReservation():
    dataSended=request.json
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    num_of_pet=dataSended['num_of_pet']
    pet_type_id=dataSended['pet_type_id']
    active=dataSended['active']
    type_of_room_id=dataSended['type_of_room_id']
    house_info_id=dataSended['house_info_id']

    try:
        createReservation(
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

