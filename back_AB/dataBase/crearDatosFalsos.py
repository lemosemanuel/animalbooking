from sympy import true
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

def createPet(name,age,pet_type):
    pet_type=str(buscar_id('pet_type','id','name',"'"+pet_type+"'"))
    insertData(
    'pet',
    "name,age,pet_type_id",
    "('"+name+"','"+age+"',"+pet_type+")"
    )
createPet('MARIA','7','VACA')

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
house_info('2',"Hotel los Perros","$140","Argentina","Buenos Aires","Parque Patricios","1246","esteban de luca")

'3'::integer, 'gatitos hoteles'::character varying, '5'::integer, '4'::integer, '1'::integer, '1'::integer, 'beiro'::character varying, '$100'::character varying)
