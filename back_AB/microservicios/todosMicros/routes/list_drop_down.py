from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id, pedir_lista

from function_jwt import validate_token


list_drop_down=Blueprint("list_drop_down",__name__)



# @list_drop_down.before_request
# def verify_token():
#     token=request.headers['Authorization'].split(' ')[1]
#     return validate_token(token,output=False)

@list_drop_down.route('/list_drop_down',methods=['GET'])
def list_drop():
    dataSended=request.json
    table_name=dataSended['table_name']
    data=pedir_lista(table_name)
    print(data)

    # createPet(name,'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')
    try:
        return jsonify({
            "message":"Data find Succesfully", 
            "succefully":True,
            "list_drop_down":data})
    except:
        return jsonify({
            "message":"Data not find",
            "succefully":False,
            "products":"ERROR A CREARLO"})

