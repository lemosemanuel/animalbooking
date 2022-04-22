import psycopg2
from dataBase.connection import connectDB


def pedir_lista(tabla):
    try:
        dataList=[]
        con, cursor = connectDB()
        sql =""" SELECT """+tabla+""".name FROM """+tabla+""" """
        cursor.execute(sql)
        for x in cursor:
            dataList.append(x[0])
        # con.commit()
        # con.close()
        print('se encontro el dato')
    except:
        print('No se encontro el dato')

    return dataList
def pedir_relaciones(tabla,tabla2,valor):
    try:
        con, cursor = connectDB()
        sql =""" SELECT """+tabla2+""".* FROM """+tabla2+""" INNER JOIN """+tabla+""" ON """+tabla+""".id= """+valor+""" """
        cursor.execute(sql)
        for x in cursor:
            print(x)
        # con.commit()
        # con.close()
        print('se encontro el dato')
    except:
        print('No se encontro el dato')

    return cursor.execute(sql)

# pedir_relaciones('avatar','tabla_relacionada','1')


def buscar_id(tabla,columnaAdevolver,column,valor):
    try:
        con, cursor = connectDB()
        if type(valor) is tuple:
            # print('es tupla')
            sql =""" SELECT """+tabla+'.'+columnaAdevolver+""" FROM """+tabla+""" WHERE """+column+""" in """+str(valor)+""" """    
        else:
            # print('no es tupla')
            sql =""" SELECT """+tabla+'.'+columnaAdevolver+""" FROM """+tabla+""" WHERE """+column+""" in ("""+valor+""") """    
        cursor.execute(sql)
        lista=()
        for x in cursor:
            lista+=x
        # con.commit()
        # con.close()
        print('se encontro el dato')
        if len(lista)==1:
            return lista[0]
        else:
            return lista
    except:
        print('No se encontro el dato de tablas: ')


# buscar_id('avatar','id','name',"'emanuel'")


# pedir_relaciones('avatar','tabla_relacionada', str(buscar_id('avatar','name',"'emanuel'")))



# relacion con 3 tablas



def pedir_relaciones_tres(tabla,nombreColumnfk,tabla2,valor):
    try:
        con, cursor = connectDB()
        sql =""" SELECT """+tabla2+'.'+nombreColumnfk+""" FROM """+tabla2+""" INNER JOIN """+tabla+""" ON """+tabla+""".id= """+valor+""" """
        cursor.execute(sql)
        lista=()
        for x in cursor:
            lista+=x
        
        # con.commit()
        # con.close()
        print('se encontro el dato')
    except:
        print('No se encontro el dato')

    return lista

# resultado=pedir_relaciones_tres('avatar','reservas_id','avatar_reservas', str(buscar_id('avatar','id','name',"'emanuel'")))
# str(resultado)
# buscar_id('reservas','name_house','id',resultado)






