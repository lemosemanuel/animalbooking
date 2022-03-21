import psycopg2

con = psycopg2.connect(
    database="animalbooking", 
    user="animal", 
    password="e36739503", 
    host="127.0.0.1", 
    port="5432")

cursor = con.cursor()

cursor.execute("DROP TABLE IF EXISTS user")


sql ='''CREATE TABLE user (
   id SERIAL PRIMARY KEY,
   name VARCHAR(20),
   name_2 VARCHAR(20),
   lastname VARCHAR(20),
   lastname_2 VARCHAR(20),
   dni VARCHAR(20),
   phone VARCHAR(20),
   mobile_phone VARCHAR(20),
   birth_date VARCHAR(20),
)'''
cursor.execute(sql)

print("Database opened successfully")