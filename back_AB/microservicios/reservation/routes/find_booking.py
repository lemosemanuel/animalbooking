from routes.beeds_free import diasLibresByHouseId

import datetime
from flask import Blueprint, request, jsonify
from dataBase.pedir_relaciones import buscar_id

# from function_jwt import validate_token


find_space=Blueprint("find_space",__name__)


# busco todas las casas en cierta zona
# luego busco las que pueden hospedar ese tipo de animal


def buscoCasasPorCiudad(city_name):
    city_id=buscar_id('city','id','name',"'"+city_name+"'")
    houses_by_city=buscar_id('house_info','id','city_id',str(city_id))

    return houses_by_city

# casasByCity=buscoCasasPorCiudad("Buenos Aires")


# filtro por mascota

def filtroPorAnimalYcity(tipo_anmial,house_by_city):
    idCasasByCityByPet={}
    id_pet=buscar_id('pet_type',"id","name","'"+tipo_anmial+"'")
    casasByCity=buscoCasasPorCiudad(house_by_city)

    for i in casasByCity:
        beed_id_by_pet=buscar_id('beed_aviable_condition','id',"pet_type_id='"+str(id_pet)+"' and house_info_id",str(i))
        if beed_id_by_pet:
            print(beed_id_by_pet)
            idCasasByCityByPet.update({i:beed_id_by_pet})
    return idCasasByCityByPet
# filtroPorAnimalYcity("PERRO",'Buenos Aires')


# dictfilt = lambda x, y: dict([ (i,x[i]) for i in x if i in set(y) ])

def buscoBeedsFreeByAnimalByCity(pet_type,city):
    dictfilt = lambda x, y: dict([ (i,x[i]) for i in x if i in set(y) ])
    casas={}
    casasId=filtroPorAnimalYcity(pet_type,city)
    for i in casasId.keys():
        try:
            a=diasLibresByHouseId(str(i))
            a=dictfilt(a,str(casasId[i]))
            casas.update({str(i):a})
        except:
            pass
    
    return casas

# casa_id_free_days=buscoBeedsFreeByAnimalByCity("PERRO","Buenos Aires")



def estaTodoEnLaOtraLista(diasLibres,diasQueBusco):
    if len(diasQueBusco)==len(set(diasQueBusco).intersection(set(diasLibres))):
        return True
    else:
        return False




# modo de lectura json
# {id_house , camas_id libres}
def verificarSiEstaDisponible(diasBuscados,pet_type,city):
    freeHouses={}
    casa_id_free_days=buscoBeedsFreeByAnimalByCity(pet_type,city)

    for idCasas in casa_id_free_days.keys():
        for idBeeds in casa_id_free_days[idCasas].keys():
            a=casa_id_free_days[idCasas][idBeeds]
            # print(a)
            if estaTodoEnLaOtraLista(a,diasBuscados):
                if idCasas in freeHouses.keys():
                    freeHouses[idCasas]+=[idBeeds]
                else:
                    freeHouses.update({idCasas:[idBeeds]})
    return freeHouses

# e=verificarSiEstaDisponible(diasBuscados,"PERRO","Buenos Aires")



# armo lista de dias que entran desde el start al end

def diasBuscados(start_day,end_day):
    listaDiasBuscados=[]
    start_day=datetime.datetime.strptime(start_day,'%Y-%m-%d').date()
    end_day=datetime.datetime.strptime(end_day,'%Y-%m-%d').date()
    dias_totales=(end_day-start_day).days
    for i in range(dias_totales):
        listaDiasBuscados.append(start_day+datetime.timedelta(days=i))
        return listaDiasBuscados

# diasBuscados('2022-3-23','2022-3-24')


# ahora podemos probar todo
# verificarSiEstaDisponible(diasBuscados('2022-3-23','2022-3-24'),"PERRO","Buenos Aires")




# {
#     "start_day":
#     "end_day":
#     "pet_id":
#     "city_id":
# }

@find_space.route('/check_aviable',methods=['GET'])
def finHouseAbiables():
    dataSended=request.json
    start_day=dataSended['start_day']
    end_day=dataSended['end_day']
    pet_id=dataSended['pet_id']
    city_id=dataSended['city_id']

    try:
        respuesta= verificarSiEstaDisponible(diasBuscados(start_day,end_day),pet_id,city_id)

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
