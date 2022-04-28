from flask import Blueprint, make_response, request, send_from_directory,render_template
from itsdangerous import base64_encode
from dataBase.insertarDatos import insertData
from os import getcwd, path, remove
from function_jwt import validate_token
from base64 import b64decode, b64encode
import json
import base64
from codecs import encode

images=Blueprint("images",__name__, template_folder='../routes')
PATH_FILES = getcwd() + "/files/"


@images.route("/file/<string:name_file>")
def get_image(name_file):
    with open("files/caca.jpg", "rb") as image_file:
        encoded_string = base64.b64encode(image_file.read())
    response = make_response(encoded_string)
    print(encoded_string)
    # response.headers.set('Content-Type', 'image/jpeg')
    # response.headers.set(
    #     'Content-Disposition', 'attachment', filename='%s.jpg')
    return render_template("index.html")
