import psycopg2
from dataBase.connection import *
from dataBase.crearTablas import *



crearTabla('avatar','''
                        avatar_info_id int not null,
                        avatar_credentials_id int not null,
            ''')


crearTabla('avatar_credentials','''
                                email varchar(20) not null CHECK (email NOT LIKE '% %'),
                                password varchar(20) not null CHECK (password NOT LIKE '% %'),
                                historical_emails varchar(20) not null CHECK (historical_emails NOT LIKE '% %'),
                                hostorical_password varchar(20) not null CHECK (hostorical_password NOT LIKE '% %'),
                                secure_code varchar(20) not null CHECK (secure_code NOT LIKE '% %')
            ''')


crearTabla('avatar_info','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %'),
                    name_2 varchar(20) not null CHECK (name_2 NOT LIKE '% %'),
                    lastname varchar(20) not null CHECK (lastname NOT LIKE '% %'),
                    lastname_2 varchar(20) not null CHECK (lastname_2 NOT LIKE '% %'),
                    type_identification varchar(20) not null CHECK (type_identification NOT LIKE '% %'),
                    identification varchar(20) not null CHECK (identification NOT LIKE '% %'),
                    age varchar(20) not null CHECK (age NOT LIKE '% %'),
                    area_code varchar(20) not null CHECK (area_code NOT LIKE '% %'),
                    house_phone varchar(20) not null CHECK (house_phone NOT LIKE '% %'),
                    mobile_phone varchar(20) not null CHECK (mobile_phone NOT LIKE '% %'),
                    country int not null,
                    city int not null,
                    district int not null,
                    cp int not null,
                    street int not null,
                    num_street varchar(20) not null CHECK (num_street NOT LIKE '% %')
            ''')

crearTabla('countries','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %')
            ''')

crearTabla('city','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %'),
                    countries_id int not null, foreign key (countries_id) references countries(id)
            ''')

crearTabla('district','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %'),
                    city_id int not null, foreign key (city_id) references city(id)
            ''')

crearTabla('cp','''
                    name varchar(20) not null CHECK (name NOT LIKE '% %'),
                    district_id int not null, foreign key (district_id) references district(id)
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
                    price varchar(20) not null check (price not like '% %'),
                    country int not null,
                    city int not null,
                    district int not null,
                    cp int not null,
                    street varchar(20) not null,
                    foreign key (avatar_id) references avatar(id)
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
crearTabla('pet','''
                    name varchar(40) not null,
                    type_of_pet 
                    reviews_id int not null,
                    foreign key (walker_info_id) references walker_info(id),
                    foreign key (reviews_id) references reviews(id)
            ''')


# sql= crearTabla('avatar','name VARCHAR(20)')

# sql= crearTabla('reservas','name_house VARCHAR(20)')


# sql= crearTabla('tabla_relacionada','name VARCHAR(20), OrderNumber int NOT NULL, FOREIGN KEY (OrderNumber) REFERENCES avatar(id)')


# sql= crearTabla('avatar_reservas','avatar_id int NOT NULL, reservas_id int NOT NULL, FOREIGN KEY (avatar_id) REFERENCES avatar(id), FOREIGN KEY (reservas_id) REFERENCES reservas(id)')



# sql= crearTabla('user_type','user_id int FOREIGN KEY REFERENCES primary_user(id)')
