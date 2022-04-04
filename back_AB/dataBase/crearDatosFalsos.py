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


