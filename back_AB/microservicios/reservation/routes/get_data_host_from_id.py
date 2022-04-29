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


# firma respuesta
# {
#     "house_id":"1",
#     "name_house":"juancito casa",
#     "adress":"esteban de luca 1851",
#     "type_of_house":"ph",
#     "anfitrion_name":"juan carlos",
#     "tipo de animales que admite":["perros","gatos","caballos"],
#     "amenities":['jardin',"balcon"],
#     "images":[],
#     "reviews_comment":["no me gusto","me gusto mucho"],
#     "calification":"(2,10)",
#     "calificationAverage":"6",
#     "description":"es un ph muy grande , tiene patio y me dedico hace mucho a esto",
#     "beed": [ 
#                 {
#                     "beed_id":"2",
#                     "services":["Comida","paseo","bano"],
#                     "beed_name":"privado",
#                     "tipo_animal":"perro"
#                 }
#             ]
# }


house_id="12"



def house_info(house_id):
    house_id,avatar_info_id,house_name,country_id,city_id,district_id,cp_id,street,description,email,phone,mobile_phone,lat,long=buscar_id('house_info','*','id',house_id)
    country_name=buscar_id('countries','name','id',str(country_id))
    city_name=buscar_id('city','name','id',str(city_id))
    district_name=buscar_id('district','name','id',str(district_id))
    cp_name=buscar_id('cp','name','id',str(cp_id))
    adrees_name= country_name+", "+city_name+", "+district_name+", "+cp_name+", "+street
    





def dataParticularHouse(house_id):
    houses={}
    house_id=house_id
    house_adress:
    name_house=buscar_id('house_info','name','id',house_id)
    images_id=buscar_id('home_info_images','images_id','house_info_id',house_id)
    # si tiene imagen
    if images_id:
        if type(images_id)==tuple:
            image=buscar_id('images','name','id',images_id)
        else:
            image=buscar_id('images','name','id',images_id)

    else:
        image=[]

    # busco los comentarios y las calificaciones
    reviews_id=buscar_id('house_info_reviews','reviews_id','house_info_id',house_id)
    # voy por el promedio de las calificaciones
    calification=[]
    calificationAverage=[]
    # voy con los comentarios
    reviews_comment=[]
    if reviews_id:
        if type(reviews_id)!= tuple:
            reviews_id=reviews_id,
        for reviews in reviews_id:
            calification.append(float(buscar_id('reviews','calification','id',str(reviews))))
            reviews_comment.append(float(buscar_id('reviews','description','id',str(reviews))))

        
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
