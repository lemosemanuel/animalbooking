import psycopg2
from dataBase.connection import *




# cursor.execute("DROP TABLE IF EXISTS user")

def crearTabla(tableName,columnasInString):
    try:
        con, cursor = connectDB()
        sql =""" CREATE TABLE """+tableName+""" ( id SERIAL PRIMARY KEY, """+columnasInString+""" )"""
        cursor.execute(sql)
        con.commit()
        con.close()
        print('Tabla creada con exito')
    except:
        print('No se pudo crear la tabla')

    return sql


# sql= crearTabla('avatar','name VARCHAR(20)')

# sql= crearTabla('reservas','name_house VARCHAR(20)')


# sql= crearTabla('tabla_relacionada','name VARCHAR(20), OrderNumber int NOT NULL, FOREIGN KEY (OrderNumber) REFERENCES avatar(id)')


# sql= crearTabla('avatar_reservas','avatar_id int NOT NULL, reservas_id int NOT NULL, FOREIGN KEY (avatar_id) REFERENCES avatar(id), FOREIGN KEY (reservas_id) REFERENCES reservas(id)')



# sql= crearTabla('user_type','user_id int FOREIGN KEY REFERENCES primary_user(id)')



