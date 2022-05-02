from grpc import services
from routes.beeds_free import diasLibresByHouseId

import datetime
from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id
from routes.find_booking import diasBuscados, verificarSiEstaDisponible



resume_data_house=Blueprint("resume_data_house",__name__)


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
# verificarSiEstaDisponible(diasBuscados('2022-3-23','2022-3-24'),"PERRO","Buenos Aires")



# tengo  que devolve:
# {
#     "house_id":"12",
#     "image":,
#     "average_price":
#     "services":
#      "calification":
# }
def resumeDataFreeHouse(house_id_and_beed_id):
    houses={}
    for i in house_id_and_beed_id.keys():
        name_house=buscar_id('house_info','name','id',i)
        images_id=buscar_id('home_info_images','images_id','house_info_id',i)
        # images_id=buscar_id('home_info_images','images_id','house_info_id',"12")
        image=[]
        # si tiene imagen
        if images_id:
            if type(images_id)!=tuple:
                images_id=images_id,
            image.append(str(buscar_id('images','name','id',str(images_id[0]))))
        else:
            image=[]

            
        reviews_id=buscar_id('house_info_reviews','reviews_id','house_info_id',i)
        calification=[]
        calificationAverage=[]
        if reviews_id:
            if type(reviews_id)!= tuple:
                reviews_id=reviews_id,
            for reviews in reviews_id:
                calification.append(float(buscar_id('reviews','calification','id',str(reviews))))
            
            calificationAverage=sum(calification)/len(calification)

        prices=[]
        for pric in house_id_and_beed_id[i]:
            bed_price=buscar_id('beed_aviable_condition','price','id',str(pric))
            prices.append(float(bed_price))
        price_average=sum(prices)/len(prices)
        
        servicios=()
        for serv in house_id_and_beed_id[i]:
            servicio=buscar_id('beed_aviable_condition_room_services','beed_services_id','beed_aviable_condition_id',str(serv))
            # print(servicio)
            if type(servicio)!=tuple:
                servicio=servicio,
            servicios+=servicio
        servicios=list(set(servicios))

        services_name_house=[]
        for service in servicios:
                    services_name=buscar_id('beed_services','name','id',str(service))
                    services_name_house.append(services_name)

        if i in houses.keys():
            houses[i].append({
                "house_id":i,
                "name":name_house,
                "calification":calificationAverage,
                "image":image,
                "services":services_name_house,
                "price": ("%.2f" % price_average)
            })
        else:
            houses.update({i:
                {
                "house_id":i,
                "name":name_house,
                "calification":calificationAverage,
                "image":image,
                "services":services_name_house,
                "price": ("%.2f" % price_average)
                }
            })        
    return houses

# resumeDataFreeHouse(data)


@resume_data_house.route('/resume_data_house',methods=['GET'])
def resume_data_hous():
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
        respuesta=resumeDataFreeHouse(respuesta)
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
