import psycopg2


def connectDB():
    con = psycopg2.connect(
        database="animalbooking", 
        user="animal", 
        password="e36739503", 
        host="127.0.0.1", 
        port="5432")
    cursor = con.cursor()

    return con, cursor

