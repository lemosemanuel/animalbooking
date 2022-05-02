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
    # "total_meters":total_meters,
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




def house_info(house_id,start_day_optional,end_day_optional,pet_type_optional,city_optional):
    houses={}
    house_id,avatar_info_id,house_name,country_id,city_id,district_id,cp_id,street,description,email,phone,mobile_phone,lat,long,type_house_id=buscar_id('house_info','*','id',str(house_id))
    country_name=buscar_id('countries','name','id',str(country_id))
    city_name=buscar_id('city','name','id',str(city_id))
    district_name=buscar_id('district','name','id',str(district_id))
    cp_name=buscar_id('cp','name','id',str(cp_id))
    adrees_name= country_name+", "+city_name+", "+district_name+", "+cp_name+", "+street
    district_name=buscar_id('district','name','id',str(district_id))
    type_house=buscar_id('type_of_house','name','id',str(district_id))
    total_meters=buscar_id('type_of_house','total_meters','id',str(district_id))
    anfitrion_name=buscar_id('avatar_info','name','id',str(avatar_info_id))
    images_id=buscar_id('home_info_images','images_id','house_info_id',str(house_id))
    # si tiene imagen
    image=[]
    # si tiene imagen
    if images_id:
        if type(images_id)!=tuple:
            images_id=images_id,
        
        for img in images_id:
            image.append(str(buscar_id('images','name','id',str(img))))
    else:
        image=[]
    print(len(image))
    reviews_id=buscar_id('house_info_reviews','reviews_id','house_info_id',str(house_id))
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
            reviews_comment.append(buscar_id('reviews','description','id',str(reviews)))

        
        calificationAverage=sum(calification)/len(calification)  

    # voy por las camas
    # tengo dos opciones... condicionar las camas segun la fecha, lugar y tipo de perro
    # si no tengo fecha restringida tomo todas las camas
    if start_day_optional =="":
        data={str(house_id):buscar_id('beed_aviable_condition',"id","house_info_id",str(house_id))}
    else:
        data=verificarSiEstaDisponible(diasBuscados(start_day_optional,end_day_optional),pet_type_optional,city_optional)
    # condicionar 

    houses.update({
        "house_id":str(house_id),
        "name_house":house_name,
        "adress":adrees_name,
        "type_of_house":type_house,
        "total_meters":total_meters,
        "anfitrion_name":anfitrion_name,
        # "type_animal_condition":
        # "amenities":
        "images":image,
        "reviews_comment":reviews_comment,
        "calification":calification,
        "calificationAverage":calificationAverage,
        "description":description,
        "beed":[]
        })

    # house_id='13'
    for i in data[str(house_id)]:
        beeds={}
        beed_id,house_info_id,start_day,end_day,pet_type_id,active,name,price=buscar_id('beed_aviable_condition','*','id',str(i))
        # beed_id=beed_id
        beed_price=price
        beed_name=name
        is_active=active,


        pet_type_id=buscar_id('pet_type','name','id',str(pet_type_id))



        beed_services=[]
        services_id=buscar_id('beed_aviable_condition_room_services','beed_services_id','beed_aviable_condition_id',str(i))
        if type(services_id)!= tuple:
            services_id=services_id,
        try:     
            for service in services_id:
                services_name=buscar_id('beed_services','name','id',str(service))
                beed_services.append(services_name)
        except:
            pass   

        if len(beed_services)<1:
            beed_services=["no incluye servicios"]
        # primero armo el json, luego lo meto en a lista de beed
        beeds.update({
            
            "beed_id":beed_id,
            "beed_price":beed_price,
            "beed_name":beed_name,
            "is_active":is_active,
            "pet_type_id":pet_type_id,
            "services":beed_services
            
        })
        # print(beeds)
        houses['beed'].append(beeds)
        # print(houses['beed'])

    return houses




# house_info('13',"2022-3-28","2022-3-29","PERRO","Buenos Aires")['beed']


@data_particular_house.route('/data_particular_house',methods=['GET'])
def data_hous():
    dataSended=request.json
    house_id=dataSended['house_id']
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    pet_id=dataSended['pet_id']
    city_id=dataSended['city_id']


    try:
        respuesta= house_info(house_id,start_day,end_day,pet_id,city_id)
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
