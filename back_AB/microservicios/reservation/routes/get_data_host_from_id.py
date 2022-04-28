from grpc import services
from routes.beeds_free import diasLibresByHouseId

import datetime
from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id
from routes.find_booking import diasBuscados, verificarSiEstaDisponible



data_particular_house=Blueprint("data_particular_house",__name__)


# necesito devolver, nombre, foto, puntuacion , servicios y precio

# tengo esto 

# {
#         "12": [
#             "5"
#         ],
#         "13": [
#             "1",
#             "2",
#             "3",
#             "4"
#         ]
# },




# data=verificarSiEstaDisponible(diasBuscados('2022-3-23','2022-3-24'),"PERRO","Buenos Aires")


def dataParticularHouse(house_id):
    houses={}
    name_house=buscar_id('house_info','name','id',house_id)
    images_id=buscar_id('home_info_images','images_id','house_info_id',house_id)
    # si tiene imagen
    if images_id:
        image=buscar_id('images','name','id',str(images_id))
    else:
        image=[]
    # busco los comentarios y las calificaciones
    reviews_id=buscar_id('house_info_reviews','reviews_id','house_info_id',house_id)
    calification=[]
    calificationAverage=[]
    if reviews_id:
        if type(reviews_id)!= tuple:
            reviews_id=reviews_id,
        for reviews in reviews_id:
            calification.append(float(buscar_id('reviews','calification','id',str(reviews))))
        
        calificationAverage=sum(calification)/len(calification)  

        # voy a los servicios por cama = e
    for e in house_id_and_beed_id[i]:
        beed_services=[]
        # number of beed id = e
        bed_price=buscar_id('beed_aviable_condition','price','id',e)
        services_id=buscar_id('beed_aviable_condition_room_services','beed_services_id','beed_aviable_condition_id',str(e))
        if type(services_id)!= tuple:
            services_id=services_id,
        try:     
            for service in services_id:
                services_name=buscar_id('beed_services','name','id',str(service))
                beed_services.append(services_name)
        except:
            pass   
        if i in houses.keys():
            houses[i].append({
                "name":name_house,
                "bed_id": e,
                "calification":calificationAverage,
                "image":image,
                "services":beed_services,
                "price": bed_price
            })
        else:
            houses.update({i:
                [{
                "name":name_house,
                "bed_id": e,
                "calification":calificationAverage,
                "image":image,
                "services":beed_services,
                "price": bed_price
                }]
            })

    return houses


# dataHouse(data)

@data_particular_house.route('/data_particular_house',methods=['GET'])
def data_hous():
    dataSended=request.json
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    pet_id=dataSended['pet_id']
    city_id=dataSended['city_id']

    # devuevo

    if start_day=="":
        start_day='2022-3-23'
    if end_day=='':
        end_day=='2022-3-24'


    try:
        respuesta= verificarSiEstaDisponible(diasBuscados(start_day,end_day),pet_id,city_id)
        respuesta=dataParticularHouse(respuesta)
        return jsonify({
            "message":"House find Succesfully",
            "succefully":True,
            'houses':respuesta   
            })
    except:
        return jsonify({
            "message":"House not find",
            "succefully":False,
            })
