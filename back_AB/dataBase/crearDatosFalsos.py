from connection import connectDB
from insertarDatos import insertData
from pedir_relaciones import buscar_id




buscar_id('countries','id','name',"'Argentina'")

pais=['Argentina','Bolivia']
insertData(
    'countries',
    "name", 
    "('"+pais[0]+"'),('"+pais[1]+"')")


insertData(
    'city',
    "name,countries_id", 
    """
    ('Buenos Aires',"""+str(buscar_id('countries','id','name',"'Argentina'"))+"""),
    ('La Paz',"""+str(buscar_id('countries','id','name',"'Bolivia'"))+"""),
    ('Cordoba',"""+str(buscar_id('countries','id','name',"'Argentina'"))+""")
    """
    )

insertData(
    'district',
    "name,city_id", 
    """
    ('Parque Patricios',"""+str(buscar_id('city','id','name',"'Buenos Aires'"))+"""),
    ('Limon',"""+str(buscar_id('city','id','name',"'La Paz'"))+"""),
    ('Capital Cordoba',"""+str(buscar_id('city','id','name',"'Cordoba'"))+""")
    """
    )

insertData(
    'cp',
    "name,district_id", 
    """
    ('1246',"""+str(buscar_id('district','id','name',"'Parque Patricios'"))+"""),
    ('er223',"""+str(buscar_id('district','id','name',"'Limon'"))+"""),
    ('323D',"""+str(buscar_id('district','id','name',"'Capital Cordoba'"))+""")
    """
    )


insertData(
    'identification_type',
    "name",
    "('DNI'),('PASAPORTE')"
    )



def insertarDataRegistro(name,name2,lastname,lastnmae2,identification_type,identification,age,area_code,house_pone,mobile_phone,countries_id,city_id,district_id,cp_id,street,num_street):
    typeDocum=str(buscar_id('identification_type','id','name',"'"+identification_type+"'"))
    country=str(buscar_id('countries','id','name',"'"+countries_id+"'"))
    city=str(buscar_id('city','id','name',"'"+city_id+"'"))
    district=str(buscar_id('district','id','name',"'"+district_id+"'"))
    cp=str(buscar_id('cp','id','name',"'"+cp_id+"'"))
    
    insertData(
        'avatar_info',
        """
            name,
            name_2,
            lastname,
            lastname_2,
            identification_type_id,
            identification,
            age,
            area_code,
            house_phone,
            mobile_phone,
            countries_id,
            city_id,
            district_id,
            cp_id,
            street,
            num_street
        """,
        "('"+name+"','"+name2+"','"+lastname+"','"+lastnmae2+"',"+typeDocum+",'"+identification+"','"+age+"','"+area_code+"','"+house_pone+"','"+mobile_phone+"',"+country+","+city+","+district+","+cp+",'"+street+"','"+num_street+"')")

insertarDataRegistro('Jairo',"Emanuel","Lemos","Musi","DNI","36739502","30","+54","49430612",'1140493827','Argentina','Buenos Aires','Parque Patricios','1246','esteban de luca 1851','1851')


def insertarPassWordYCon(avatarid,email,password,histEmails,histPassword,secureCode):
    # print(str(histEmails))
    # print(str(histPassword))

    insertData('avatar_credentials','avatar_info_id, email, password, hist_email, hist_pass, secure_code',"("+avatarid+",'"+email+"','"+password+"','"+str(histEmails)+"','"+str(histPassword)+"','"+secureCode+"')")

insertarPassWordYCon('2','lemos.ema@gmail.com','123','[''lemos@gmail.com'',''juana@gmail.com'']','[''lemos@gmail.com'',''juana@gmail.com'']','12321')



################# VAMOS CON LOS ANIMALES ################

def createTypeOfPet(pet_type):
    insertData(
    'pet_type',
    "name",
    "('"+pet_type+"')"
    )
createTypeOfPet('PERRO')

def create_gender(name):
    insertData(
    'gender',
    "name",
    "('"+name+"')"
    )
create_gender('Masculino')

def create_size_of_pet(name):
    insertData(
    'size_of_pet',
    "name",
    "('"+name+"')"
    )
create_size_of_pet('Muy Grande')

def create_body_condition(name):
    insertData(
    'body_condition',
    "name",
    "('"+name+"')"
    )
create_body_condition('Grossly Obese')

def create_habitat(name):
    insertData(
    'habitat',
    "name",
    "('"+name+"')"
    )
create_habitat('Patio')

def create_type_behavior(name):
    insertData(
    'type_behavior',
    "name",
    "('"+name+"')"
    )
create_habitat('Dormilon')


def createPet(name,age,pet_type_id,gender_id,neutered,spayed,weight,size_of_pet_id,body_condition_id,race,color,habitat_id,adress,phones,medicines,chronic_illness,allergies,fractures,vaccines,nutrition,type_behavior,other_description):
    pet_type_id=str(buscar_id('pet_type','id','name',"'"+pet_type_id+"'"))
    gender_id=str(buscar_id('gender','id','name',"'"+gender_id+"'"))
    size_of_pet_id=str(buscar_id('size_of_pet','id','name',"'"+size_of_pet_id+"'"))
    body_condition_id=str(buscar_id('body_condition','id','name',"'"+body_condition_id+"'"))
    habitat_id=str(buscar_id('habitat','id','name',"'"+habitat_id+"'"))

    insertData(
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
        "('"+name+"','"+age+"',"+pet_type_id+","+gender_id+",'"+neutered+"','"+spayed+"','"+weight+"',"+size_of_pet_id+","+body_condition_id+",'"+race+"','"+color+"',"+habitat_id+",'"+adress+"','"+phones+"','"+medicines+"','"+chronic_illness+"','"+allergies+"','"+fractures+"','"+vaccines+"','"+nutrition+"','"+type_behavior+"','"+other_description+"')")

    print("('"+name+"','"+age+"',"+pet_type_id+","+gender_id+","+neutered+","+spayed+",'"+weight+"',"+size_of_pet_id+","+body_condition_id+",'"+race+"','"+color+"',"+habitat_id+",'"+adress+"','"+phones+"','"+medicines+"','"+chronic_illness+"','"+allergies+"',"+fractures+",'"+vaccines+"','"+nutrition+"','"+type_behavior+"','"+other_description+"')")

createPet("Juver",'13',"PERRO","Masculino",'true','true','13','Chico','Thin','Golden','Negro','Departamento','esteban de luca 1851','2312321','tiene que tomar una todos los dias','dolor de cabeza','a los manies','true','vacuna de covid aplicada','solo come carne','se porta bien , no con los chicos','tienen que tener cuidado con los pajaros, se los come')



def avatar_pet(avatar_info_id,pet_type_id):
    insertData(
    'avatar_pet',
    "avatar_info_id,pet_type_id",
    "("+avatar_info_id+","+pet_type_id+")"
    )
avatar_pet('4','3')


################################# VAMOS CON LAS CASASSSSSSSSSSSSSSSSS #############################

def house_services(name):
    insertData(
    'house_services',
    "name",
    "('"+name+"')"
    )
house_services("LO PASO A BUSCAR")

def house_info(avatar_info_id,name,price,countries_id,city_id,district_id,cp_id,street):
    # avatar=str(buscar_id('avatar_info','id','name',"'"+avatar_info_id+"'"))

    country=str(buscar_id('countries','id','name',"'"+countries_id+"'"))
    city=str(buscar_id('city','id','name',"'"+city_id+"'"))
    district=str(buscar_id('district','id','name',"'"+district_id+"'"))
    cp=str(buscar_id('cp','id','name',"'"+cp_id+"'"))

    print(country,city,district,cp)

    # avatar_info_id='2'
    # name='Hotel los perros'
    # price='$145'
    # country='5'
    # city='4'
    # district='1'
    # cp_id='1'
    # street='esteban de luca'
    insertData(
    'house_info',
    "avatar_info_id, name,price, country_id, city_id, district_id, cp_id, street",
    "("+avatar_info_id+",'"+name+"','"+price+"',"+country+","+city+","+district+","+cp+",'"+street+"')"
    )
house_info('4',"Gatos boutique","$30","Bolivia","La Paz","Parque Patricios","1246","la paz de luca")

def type_of_room(name,price):
    insertData(
        'type_of_room',
        'name,price',
        "('"+name+"','"+price+"')"
    )
type_of_room('spa_room','$500')

def aviable_house(house_info_id,start_day,end_day,num_of_pet,pet_type_id,active,type_of_room_id):
    pet_type_id=str(buscar_id('pet_type','id','name',"'"+pet_type_id+"'"))
    type_of_room_id=str(buscar_id('type_of_room','id','name',"'"+type_of_room_id+"'"))

    insertData(
    'house_aviable',
    "house_info_id, start_day,end_day, num_of_pet, pet_type_id, active, type_of_room_id",
    "("+house_info_id+",'"+start_day+"','"+end_day+"',"+num_of_pet+","+pet_type_id+","+active+","+type_of_room_id+")"
    )

aviable_house('1','04/11/2022','08/12/2022','3','VACA','False','private_room')


def reservations(house_info_id,avatar_info_id,pet_id,start_day,end_day,status):
    # tengo que checkear que la fecha disponible sea para el tipo de animal
    # tengo que checkear que el owner tiene ese animal (y que este disponible)

    # house_info_id='1'
    # avatar_info_id='4'
    # pet_id='1'
    # start_day='04/11/2022'
    # end_day='08/12/2022'
    # status='aconfirmar'
    insertData(
    'reservations',
    'house_info_id,avatar_info_id,pet_id,start_day,end_day,status',
    "("+house_info_id+","+avatar_info_id+","+pet_id+",'"+start_day+"','"+end_day+"','"+status+"')"
    )

reservations('3','4','2','04/11/2022','08/12/2022','Aconfirmar')


def reviews(description,calification):
    insertData(
    'reviews',
    'description,calification',
    "('"+description+"','"+calification+"')"
    )

reviews('el hostel fue bonito ','7')

def house_info_reviews(house_info_id,reviews_id):
    insertData(
    'house_info_reviews',
    'house_info_id,reviews_id',
    "("+house_info_id+","+house_info_id+")"
    )
house_info_reviews('3','4')


def walker_info(avatar_info_id,price,is_active):
    insertData(
    'walker_info',
    'avatar_info_id,price,is_active',
    "("+avatar_info_id+",'"+price+"','"+is_active+"')"
    )    
walker_info('3','$140','False')


def walker_info_reviews(walker_info_id,reviews_id):
    insertData(
    'walker_info_reviews',
    'walker_info_id,reviews_id',
    "("+walker_info_id+","+reviews_id+")"
    )
walker_info_reviews('2','3')




def language(name):
    insertData(
    'language',
    'name',
    "('"+name+"')"
    )
language('english')

def page_name(name):
    insertData(
    'page_name',
    'name',
    "('"+name+"')"
    )
page_name('registro_2')

def page_string(name):
    insertData(
    'page_string',
    'name',
    "('"+name+"')"
    )
page_string('ID')

def language_page_name_page_string(language_id,page_name_id,page_string_id):
    insertData(
    'language_page_name_page_string',
    'language_id,page_name_id,page_string_id',
    "("+language_id+","+page_name_id+","+page_string_id+")"
    )

language_page_name_page_string('2','1','8')


