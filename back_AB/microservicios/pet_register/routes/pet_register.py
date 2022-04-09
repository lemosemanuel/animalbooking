from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token


pet_register=Blueprint("pet_register",__name__)


def createPetInfo(name,age,pet_type_id,gender_id,neutered,spayed,weight,size_of_pet_id,body_condition_id,race,color,habitat_id,adress,phones,medicines,chronic_illness,allergies,fractures,vaccines,nutrition,type_behavior,other_description,avatar_id):
    pet_type_id=str(buscar_id('pet_type','id','name',"'"+pet_type_id+"'"))
    gender_id=str(buscar_id('gender','id','name',"'"+gender_id+"'"))
    size_of_pet_id=str(buscar_id('size_of_pet','id','name',"'"+size_of_pet_id+"'"))
    body_condition_id=str(buscar_id('body_condition','id','name',"'"+body_condition_id+"'"))
    habitat_id=str(buscar_id('habitat','id','name',"'"+habitat_id+"'"))
    neutered=str(neutered).lower()
    spayed=str(spayed).lower()
    fractures=str(fractures).lower()
    
    # print(
    #     type(name),
    #     type(age),
    #     type(pet_type_id),
    #     type(gender_id),
    #     type(neutered),
    #     type(spayed),
    #     type(weight),
    #     type(size_of_pet_id),
    #     type(body_condition_id),
    #     type(race),
    #     type(color),
    #     type(habitat_id),
    #     type(adress),
    #     type(phones),
    #     type(medicines),
    #     type(chronic_illness),
    #     type(allergies),
    #     type(fractures),
    #     type(vaccines),
    #     type(nutrition),
    #     type(type_behavior),
    #     type(other_description)
    # )
    
    # inserto la data en pet
    id_insert=insertData(
        'pet',
        """
            name,
            age,
            pet_type_id,
            gender_id,
            neutered,
            spayed,
            weight,
            size_of_pet_id,
            body_condition_id,
            race,
            color,
            habitat_id,
            adress,
            phones,
            medicines,
            chronic_illness,
            allergies,
            fractures,
            vaccines,
            nutrition,
            type_behavior,
            other_description
        """,
        "('"+name+"','"+age+"','"+pet_type_id+"','"+gender_id+"','"+neutered+"','"+spayed+"','"+weight+"','"+size_of_pet_id+"','"+body_condition_id+"','"+race+"','"+color+"','"+habitat_id+"','"+adress+"','"+phones+"','"+medicines+"','"+chronic_illness+"','"+allergies+"','"+fractures+"','"+vaccines+"','"+nutrition+"','"+type_behavior+"','"+other_description+"')"
        )
    print(id_insert)
    print(avatar_id)
    # inserto el id en la tabla avatar_pet
    insertData('avatar_pet','avatar_info_id, pet_id',str(avatar_id)+", "+str(id_insert))

# insertData('avatar_pet','avatar_info_id, pet_id','28,2')


# createPetInfo("Juver",'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')



@pet_register.before_request
def verify_token():
    token=request.headers['Authorization'].split(' ')[1]
    return validate_token(token,output=False)

@pet_register.route('/pet_register',methods=['GET'])
def createPet():
    dataSended=request.json
    name = dataSended['name']
    age = dataSended['age']
    pet_type_id = dataSended['pet_type_id']
    gender_id = dataSended['gender_id']
    neutered = dataSended['neutered']
    spayed = dataSended['spayed']
    weight = dataSended['weight']
    size_of_pet_id = dataSended['size_of_pet_id']
    body_condition_id = dataSended['body_condition_id']
    race = dataSended['race']
    color = dataSended['color']
    habitat_id = dataSended['habitat_id']
    adress = dataSended['adress']
    phones = dataSended['phones']
    medicines = dataSended['medicines']
    chronic_illness = dataSended['chronic_illness']
    allergies = dataSended['allergies']
    fractures = dataSended['fractures']
    vaccines = dataSended['vaccines']
    nutrition = dataSended['nutrition']
    type_behavior = dataSended['type_behavior']
    other_description = dataSended['other_description']
    avatar_id=dataSended['avatar_id']

    # createPet(name,'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')
    try:
        createPetInfo(
            name,
            age,
            pet_type_id,
            gender_id,
            neutered,
            spayed,
            weight,
            size_of_pet_id,
            body_condition_id,
            race,
            color,
            habitat_id,
            adress,
            phones,
            medicines,
            chronic_illness,
            allergies,
            fractures,
            vaccines,
            nutrition,
            type_behavior,
            other_description,
            avatar_id
        )
        return jsonify({"message":"Avatar Added Succesfully", "products":"CREADO CON EXITO"})
    except:
        return jsonify({"message":"Avatar Added Succesfully", "products":"ERROR A CREARLO"})

