import datetime
from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


# {
#     "city":"",
#     "start-date":"",
#     "finish-date":"",
#     "type_of_pet":"",
#     "quantity":""
# }
# SELECT * FROM YouTable WHERE col3 = 1 AND col2 in ('B','D');

def transformoAtupla(lista):
    if type(lista)!=tuple:
        lista=(lista,)
        return lista
    else:
        return lista


# dias libres que tienen las camas en un hotel
def beeds_days_conditions(house_info_id):
    house_beed_condition={}
    # busco en beed_aviable_condition las camas con ese id house
    beed_start_day=transformoAtupla(buscar_id('beed_aviable_condition','start_day,id','house_info_id',house_info_id))
    beed_end_day=transformoAtupla(buscar_id('beed_aviable_condition','end_day,id','house_info_id',house_info_id))

    # hago la lista de los dias condicionados por cada cama
    lista_dias_por_cama_id=[]
    for i in range(len(beed_start_day)):
        if type(beed_start_day[i]) == datetime.date:
            distancia_dias=(beed_end_day[i]-beed_start_day[i]).days
            # sumo dia a dia y creo la lista
            for e in range(distancia_dias):
                lista_dias_por_cama_id.append(beed_start_day[i]+datetime.timedelta(days=e))
            house_beed_condition.update({str(beed_start_day[i+1]):lista_dias_por_cama_id})
            lista_dias_por_cama_id=[]
                # lista_dias_por_cama_id.append(beed_start_day[i+1])

    return house_beed_condition
    # ya tengo las fechas , id de la room que estan condicionadas
    # ahora le tengo que restar las reservadas
# beed_conditions=beeds_days_conditions('13')

def diasReservadosPorCama(camaId):
    
    beed_start_day=transformoAtupla(buscar_id('reservations','start_day',"status='confirmado' and bed_aviable_condition_id",camaId))
    beed_end_day=transformoAtupla(buscar_id('reservations','end_day',"status='confirmado' and bed_aviable_condition_id",camaId))

    lista_dias_reservados=[]
    beed_booking_days={}
    for i in range(len(beed_start_day)):
        distancia_dias=(beed_end_day[i]-beed_start_day[i]).days
        for e in range(distancia_dias):
            lista_dias_reservados.append(beed_start_day[i]+datetime.timedelta(days=e))
            beed_booking_days={camaId:lista_dias_reservados}

    return beed_booking_days

# diasReservadosCama=diasReservadosPorCama('2')


# remuevo los maches en dos listas
def removeMaches(listCondicion,listReservados):
    new_ra = [v for v in listCondicion if v not in listReservados]
    return new_ra




def diasLibresByHouseId(house_info_id):
    beed_conditions=beeds_days_conditions(house_info_id)
    for e in beed_conditions.keys():
        diasReservadosCama=diasReservadosPorCama(e)
        # print(e)
        # for i in diasReservadosCama.keys():
        try:
            a=removeMaches(beed_conditions[e],diasReservadosCama[e])
            # print(a)
            beed_conditions[e]=a
        except:
            pass

    return beed_conditions

# camasLibres=diasLibresByHouseId('13')




