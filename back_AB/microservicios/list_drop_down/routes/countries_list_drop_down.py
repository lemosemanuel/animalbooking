from tokenize import String
from flask import Blueprint, request, jsonify

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


countries_list_drop_down=Blueprint("countries_list_drop_down",__name__)



# @list_drop_down.before_request
# def verify_token():
#     token=request.headers['Authorization'].split(' ')[1]
#     return validate_token(token,output=False)

@countries_list_drop_down.route('/countries_list_drop_down',methods=['GET'])
def list_drop():
    dataSended=request.json
    print(dataSended)
    try:
        if dataSended['country']:
            country_name=dataSended['country']
            country_id=buscar_id('countries','id','name',"'"+country_name+"'")
            cities=buscar_id('city','name','countries_id',"'"+str(country_id)+"'")
            if type(cities)==str:
                cities=[cities]

            try:
                return jsonify({
                "message":"Data find Succesfully", 
                "succefully":True,
                "list_drop_down":cities})
            except:
                return jsonify({
                    "message":"Data not find",
                    "succefully":False,
                    "products":"ERROR A CREARLO"})
    except:
        pass
    if dataSended['city']:
        city_name=dataSended['city']
        city_id=buscar_id('city','id','name',"'"+city_name+"'")
        districts=buscar_id('district','name','city_id',"'"+str(city_id)+"'")
        if type(districts)==str:
            districts=[districts]
        try:
            return jsonify({
            "message":"Data find Succesfully", 
            "succefully":True,
            "list_drop_down":districts})
        except:
            return jsonify({
                "message":"Data not find",
                "succefully":False,
                "products":"ERROR A CREARLO"})



