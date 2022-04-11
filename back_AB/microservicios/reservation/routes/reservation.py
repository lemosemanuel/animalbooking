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
    start_day=datetime.datetime.strptime(start_day,'%Y-%m-%d').date()
    end_day=datetime.datetime.strptime(end_day,'%Y-%m-%d').date()
    print(type(start_day))



    # primero me fijo si esta dentro de lo habilitado por el lugar
    if start_day_aviable <= start_day and end_day_aviable >= start_day:
        if start_day_aviable <= end_day and end_day_aviable >= end_day:
            print('esta dentro de lo habilitado')
            # checkeo si el tipo de animal es el que el hoster puse
            id_pet_permite=buscar_id('room_aviable','pet_type_id','type_of_room_id',type_of_room_id)
            id_pet_want=buscar_id('pet_type','id','name',"'"+pet_id+"'")
            
            if id_pet_permite == id_pet_want:
                print('permitido')
 
                # hago la lista de todos los dias que se quiere quedar
                listaDiasAReservar=[]
                cantDias=(end_day - start_day).days
                for i in range(cantDias):
                    listaDiasAReservar.append(start_day+datetime.timedelta(days=i))
                
                    print(listaDiasAReservar)
                    print('dias a reservar')
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
                    print(listaDiasReservados)
                    
                    if any(x in listaDiasAReservar for x in listaDiasReservados):
                            print('no se puede')
                    else:
                        print ('se puede')
                        print(type_of_room_id,avatar_info_id,id_pet_want,start_day,end_day,status)
                        print("("+type_of_room_id+",'"+avatar_info_id+"',"+id_pet_want+",'"+str(start_day)+"','"+str(end_day)+"','"+status+"')")

                        id_insert=insertData(
                            'reservations',
                            """
                                type_of_room_id,avatar_info_id,pet_id,start_day,end_day,status
                            """,
                            "("+type_of_room_id+","+avatar_info_id+","+id_pet_want+",'"+str(start_day)+"','"+str(end_day)+"','"+status+"')"
                            )

            else:
                print('no se puede esa especie de animal')
        else:
            print('fuera de lo habilitado por el hoster')
    else:
        print('fuera de lo habilitado por el hoster')
# listaDiasAReservar=[datetime.date(2022, 4, 23), datetime.date(2022, 4, 24)]
# listaDiasReservados=[datetime.date(2022, 4, 24), datetime.date(2022, 4, 26)]

# createReservation('1','3','1',datetime.date(2022, 4, 27),datetime.date(2022, 4, 28),'se')






@reservation.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@reservation.route('/reservation',methods=['GET'])
def createNewReservation():
    dataSended=request.json
    type_of_room_id=dataSended['type_of_room_id']
    avatar_info_id=dataSended['avatar_info_id']
    pet_id=dataSended['pet_id']
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    status=dataSended['status']

    try:
        createReservation(
            type_of_room_id,
            avatar_info_id,
            pet_id,
            start_day,
            end_day,
            status            
            )
        return jsonify({"message":"Avatar Added Succesfully", "products":"Se Realizo la reserva con exito"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

