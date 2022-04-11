from flask import Blueprint, request, send_from_directory
from dataBase.insertarDatos import insertData
from os import getcwd, path, remove
from function_jwt import validate_token


images=Blueprint("images",__name__)

PATH_FILES = getcwd() + "/files/"



@images.route("/file/<string:name_file>")
def get_image(name_file):
    return send_from_directory(PATH_FILES, path=name_file, as_attachment=False)