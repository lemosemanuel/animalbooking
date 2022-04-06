import psycopg2
from connection import *
from crearTablas import *
from insertarDatos import insertData



crearTabla('avatar','''
                        avatar_info_id int not null,
                        avatar_credentials_id int not null,
                        house_info_id int not null,

            ''')



crearTabla('countries','''
                    name varchar(20) not null
            ''')

crearTabla('city','''
                    name varchar(20) not null,
                    countries_id int not null, foreign key (countries_id) references countries(id)
            ''')

crearTabla('district','''
                    name varchar(20) not null,
                    city_id int not null, foreign key (city_id) references city(id)
            ''')

crearTabla('cp','''
                    name varchar(20) not null,
                    district_id int not null, foreign key (district_id) references district(id)
            ''')

crearTabla('identification_type','''
                    name varchar(20) not null
            ''')


crearTabla('avatar_info','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %'),
                    name_2 varchar(20) not null CHECK (name_2 NOT LIKE '% %'),
                    lastname varchar(20) not null CHECK (lastname NOT LIKE '% %'),
                    lastname_2 varchar(20) not null CHECK (lastname_2 NOT LIKE '% %'),
                    identification_type_id int not null,
                    identification varchar(30) not null CHECK (identification NOT LIKE '% %'),
                    age varchar(20) not null CHECK (age NOT LIKE '% %'),
                    area_code varchar(20) not null,
                    house_phone varchar(20) not null CHECK (house_phone NOT LIKE '% %'),
                    mobile_phone varchar(20) not null CHECK (mobile_phone NOT LIKE '% %'),
                    countries_id int not null,
                    city_id int not null,
                    district_id int not null,
                    cp_id int not null,
                    street varchar(100) not null,
                    num_street varchar(20) not null CHECK (num_street NOT LIKE '% %'),
                    foreign key (identification_type_id) references identification_type(id),
                    foreign key (countries_id) references countries(id),
                    foreign key (city_id) references city(id),
                    foreign key (district_id) references district(id),
                    foreign key (cp_id) references cp(id)
            ''')


crearTabla('avatar_credentials','''
                                avatar_info_id int not null,
                                email varchar(50) not null,
                                password varchar(50) not null,
                                hist_email varchar not null,
                                hist_pass varchar not null,
                                secure_code varchar not null,
                                foreign key (avatar_info_id) references avatar_info(id)
            ''')        
# vamos con los tipos de usuarios
crearTabla('type_of_user','''
                    name varchar(20) not null
            ''')

crearTabla('avatar_type_of_user','''
                    avatar_id int not null,
                    type_id int not null,
                    foreign key (avatar_id) references avatar(id),
                    foreign key (type_id) references type_of_user(id)

            ''')


# vamos con los datos de la casa
crearTabla('house_info','''
                    avatar_id int not null,
                    name varchar(20) not null,
                    price varchar(20) not null,
                    country int not null,
                    city int not null,
                    district int not null,
                    cp int not null,
                    street varchar(20) not null,
                    foreign key (avatar_id) references avatar(id),
                    foreign key (countries_id) references countries(id),
                    foreign key (city_id) references city(id),
                    foreign key (district_id) references district(id),
                    foreign key (cp_id) references cp(id)
            ''')

crearTabla('reviews','''
                    description varchar(50) not null,
                    calification varchar(20) not null
            ''')

crearTabla('house_info_reviews','''
                    house_info_id int not null,
                    reviews_id int not null,
                    foreign key (house_info_id) references house_info(id),
                    foreign key (reviews_id) references reviews(id)
            ''')

crearTabla('house_services','''
                    name varchar(20) not null
            ''')

crearTabla('house_info_house_services','''
                    house_info_id int not null,
                    house_services_id int not null,
                    foreign key (house_info_id) references house_info(id),
                    foreign key (house_services_id) references house_services(id)
            ''')


# hacemos el paseador
crearTabla('walker_info','''
                    avatar_id int not null,
                    price varchar(20) not null,
                    is_active boolean not null,
                    foreign key (avatar_id) references avatar(id)
            ''')

crearTabla('walker_info_reviews','''
                    walker_info_id int not null,
                    reviews_id int not null,
                    foreign key (walker_info_id) references walker_info(id),
                    foreign key (reviews_id) references reviews(id)
            ''')


# vamos con los animales
crearTabla('pet_type','''
                name varchar(20) not null
            ''')



crearTabla('pet','''
                    name varchar(40) not null,
                    age int not null,
                    pet_type_id int not null,
                    foreign key (pet_type_id) references pet_type(id)
            ''')

crearTabla('avatar_pet','''
                    avatar_info_id int not null,
                    pet_type_id int not null,
                    foreign key (avatar_info_id) references avatar_info(id),
                    foreign key (pet_type_id) references pet_type(id)
            ''')

# reservas
# los dias que la casa pone desde el comienzo y condiciones
crearTabla('type_of_room','''
                    name varchar(20) not null,
                    price varchar(20) not null
        ''')

crearTabla('house_aviable','''
                    house_info_id int not null,
                    start_day date not null,
                    end_day date not null,
                    num_of_pet int not null,
                    pet_type_id int not null,
                    active boolean not null,
                    type_of_room_id int not null,
                    foreign key (house_info_id) references house_info(id),
                    foreign key (pet_type_id) references pet_type(id),
                    foreign key (type_of_room_id) references type_of_room(id)
            ''')

crearTabla('reservations','''
                    house_info_id int not null,
                    avatar_id int not null,
                    pet_id int not null,
                    start_day date not null,
                    end_day date not null,
                    status varchar(20) not null,
                    foreign key (house_info_id) references house_info(id),
                    foreign key (avatar_id) references avatar(id),
                    foreign key (pet_id) references pet(id)
            ''')

    


#####################################      INGRESAR DATOSS        #######################################################

insertData('avatar',' avatar_info_id, avatar_credentials_id, house_info_id','(1,1,1),(2,2,1),')



# varios datos
# insertData('avatar',"name,type_id", '12,1')

# insertData('avatar',"name", "'emanuel'")


# sql= crearTabla('avatar','name VARCHAR(20)')

# sql= crearTabla('reservas','name_house VARCHAR(20)')


# sql= crearTabla('tabla_relacionada','name VARCHAR(20), OrderNumber int NOT NULL, FOREIGN KEY (OrderNumber) REFERENCES avatar(id)')


# sql= crearTabla('avatar_reservas','avatar_id int NOT NULL, reservas_id int NOT NULL, FOREIGN KEY (avatar_id) REFERENCES avatar(id), FOREIGN KEY (reservas_id) REFERENCES reservas(id)')



# sql= crearTabla('user_type','user_id int FOREIGN KEY REFERENCES primary_user(id)')
