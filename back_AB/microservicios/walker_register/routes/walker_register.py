from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


walker_register=Blueprint("walker_register",__name__)


def createWalker(avatar_info_id,price,is_active, lat, lon):

    id_insert=insertData(
        'walker_info',
        """
            avatar_info_id,price,is_active, lat, lon
        """,
        "("+avatar_info_id+",'"+price+"',"+is_active+",'"+lat+"','"+lon+"')"
        )

# createWalker('2','$145','false','23.232','232.23')


# insertData('avatar_pet','avatar_info_id, pet_id','28,2')


# createPetInfo("Juver",'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')



@walker_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@walker_register.route('/walker_register',methods=['GET'])
def createPet():
    dataSended=request.json
    avatar_info_id = dataSended['avatar_info_id']
    price = dataSended['price']
    is_active = dataSended['is_active']
    lat = dataSended['lat']
    lon = dataSended['lon']

    # createPet(name,'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')
    try:
        createWalker(
            avatar_info_id,
            price,
            is_active,
            lat,
            lon
        )
        return jsonify({"message":"Avatar Added Succesfully", "products":" WALKER CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

