from jwt import encode, decode
from jwt import exceptions
import os
from datetime import datetime, timedelta
from flask import jsonify
from env import secretkey


def expire_date(days: int):
    now = datetime.now()
    new_date = now + timedelta(days)
    return new_date


def write_token(data: dict):
    token = encode(
        payload={**data, "exp": expire_date(2)},
        key=secretkey,
        algorithm="HS256")
    # return token.encode("UTF-8")
    return token


def validate_token(token, output=False):
    try:
        if output:
            return decode(token, key=secretkey(), algorithms=["HS256"])
        decode(token, key=secretkey(), algorithms=["HS256"])
    except exceptions.DecodeError:
        response = jsonify({"message": "Invalid Token"})
        response.status_code = 401
        return response
    except exceptions.ExpiredSignatureError:
        response = jsonify({"message": "Token Expired"})
        response.status_code = 401
        return response


# data1={"username":"ema","paswword":"123"}

# write_token(data=data1)

