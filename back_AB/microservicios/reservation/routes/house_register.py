from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


house_register=Blueprint("house_register",__name__)


# servicios y dias habiles  y el tipo de habitacion
# avatar_info_id, name, country_id, city_id, district_id, cp_id, street, price, description, email, phone, mobile_phone, lat,long,type_of_room_name,type_of_room_price,start_day,end_day,num_of_pet,pet_type_active

def createHouseInfo(avatar_info_id, name, country_id, city_id, district_id, cp_id, street, description, email, phone, mobile_phone, lat,lon):
    country_id=str(buscar_id('countries','id','name',"'"+country_id+"'"))
    city_id=str(buscar_id('city','id','name',"'"+city_id+"'"))
    district_id=str(buscar_id('district','id','name',"'"+district_id+"'"))
    cp_id=str(buscar_id('cp','id','name',"'"+cp_id+"'"))
    
    id_insert=insertData(
        'house_info',
        """
            avatar_info_id, name, country_id, city_id, district_id, cp_id, street, description, email, phone, mobile_phone, lat,lon
        """,
        "("+avatar_info_id+",'"+name+"',"+country_id+","+city_id+","+district_id+","+cp_id+",'"+street+"','"+description+"','"+email+"','"+phone+"','"+mobile_phone+"','"+lat+"','"+lon+"')"
        )

    
    print(id_insert)





@house_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@house_register.route('/house_register',methods=['GET'])
def createHo():
    dataSended=request.json
    avatar_info_id=dataSended['avatar_info_id']
    name=dataSended['name']
    country_id=dataSended['country_id']
    city_id=dataSended['city_id']
    district_id=dataSended['district_id']
    cp_id=dataSended['cp_id']
    street=dataSended['street']
    description=dataSended['description']
    email=dataSended['email']
    phone=dataSended['phone']
    mobile_phone=dataSended['mobile_phone']
    lat=dataSended['lat']
    lon=dataSended['lon']

    try:
        createHouseInfo(
            avatar_info_id,
            name,
            country_id,
            city_id,
            district_id,
            cp_id,
            street,
            description,
            email,
            phone,
            mobile_phone,
            lat,
            lon        )
        return jsonify({"message":"Avatar Added Succesfully", "products":"CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

