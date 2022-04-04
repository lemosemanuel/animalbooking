from cmath import isnan
from flask import Flask, jsonify, request
import sys

from numpy import NaN
from pandas import isnull
# insert at 1, 0 is the script path (or '' in REPL)
sys.path.append('/home/jairo/Desktop/codigos/flutter/flutter/animal-booking/back_AB')
from dataBase.pedir_relaciones import *

app= Flask(__name__)



@app.route('/register',methods=['GET'])
def addProduct():
    respuesta=request.json
    
    print(respuesta['ema'])
    respuesta=buscar_id('avatar_info','id','name',"'emanuel'")
    if respuesta:
        return jsonify({"message":"Product Added Succesfully", "products":respuesta})
    else:
    # new_product= {
    #     "name": request.json['name'],
    #     "price":request.json['price'],
    #     "quantity":request.json['quantity']
    # }
    # products.append(new_product)
        return jsonify({"message":"Product Added Succesfully", "products":"no existe emanuel"})


if __name__ =="__main__":
    app.run(debug=True,port=5000)