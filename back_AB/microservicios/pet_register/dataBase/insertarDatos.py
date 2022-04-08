import psycopg2
from dataBase.connection import connectDB

def insertData(tabla,columns,values):
    try:
        con, cursor = connectDB()
        if '(' in values:
            sql =""" INSERT INTO """+tabla+""" ("""+columns+""") VALUES """+values+""" ;"""
        else:
            sql =""" INSERT INTO """+tabla+""" ("""+columns+""") VALUES ("""+values+""") ;"""
        cursor.execute(sql)
        con.commit()
        con.close()
        print('Tabla creada con exito')
    except:
        print('No se pudo crear la tabla')

    return sql

def insertDatataWhere(tabla,columns,values,where_column,where_value):
    try:
        con, cursor = connectDB()
        if '(' in values:
            sql ="""UPDATE public."""+tabla+""" SET """+columns+""" = '"""+values+"""' WHERE """+where_column+""" = """+where_value+"""; """

        else:
            sql ="""UPDATE public."""+tabla+""" SET """+columns+""" = '"""+values+"""' WHERE """+where_column+""" = """+where_value+"""; """

        cursor.execute(sql)
        con.commit()
        con.close()
        print('Tabla creada con exito')
    except:
        print('No se pudo crear la tabla')

    return sql

# insertDatataWhere('avatar_credentials','secure_code','23','avatar_info_id','2')

# varios datos
# isertData('avatar',"name,type_id", '12,1')

# insertData('avatar',"name", "'emanuel'")
# insertData('reservas',"name_house", "'casa de emanuel'")
# insertData('avatar_reservas',"avatar_id,reservas_id", "1,1")



# si pongo 2 no va a funcionar ya que es una FK relacionada con la tabla avatar la cual solo tiene 1 id
# isertData('tabla_relacionada','name,ordernumber',"'juano',2")

# insertData('tabla_relacionada','name,ordernumber',"'emi',1")


# con, cursor = connectDB()
# cursor.execute("""SELECT table_name FROM information_schema.tables
#        WHERE table_schema = 'public'""")

# for table in cursor.fetchall():
#     print(table)