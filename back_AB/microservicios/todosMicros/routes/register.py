from flask import Blueprint, request, jsonify
from dataBase.insertarDatos import insertData

from dataBase.pedir_relaciones import buscar_id

from function_jwt import validate_token, write_token


user_register=Blueprint("user_register",__name__)


def insertarDataRegistro(name,name2,lastname,lastnmae2,identification_type,identification,age,area_code,house_pone,mobile_phone,countries_id,city_id,district_id,cp_id,street,num_street):
    print("type of doc")
    typeDocum=str(buscar_id('identification_type','id','name',"'"+identification_type+"'"))
    print("country")
    country=str(buscar_id('countries','id','name',"'"+countries_id+"'"))
    print("city")
    city=str(buscar_id('city','id','name',"'"+city_id+"'"))
    print("district")
    district=str(buscar_id('district','id','name',"'"+district_id+"'"))
    # cp=str(buscar_id('cp','id','name',"'"+cp_id+"'"))
    
    idUser=insertData(
        'avatar_info',
        """
            name,
            name_2,
            lastname,
            lastname_2,
            identification_type_id,
            identification,
            age,
            area_code,
            house_phone,
            mobile_phone,
            countries_id,
            city_id,
            district_id,
            cp_id,
            street,
            num_street
        """,
        "('"+name+"','"+name2+"','"+lastname+"','"+lastnmae2+"',"+typeDocum+",'"+identification+"','"+age+"','"+area_code+"','"+house_pone+"','"+mobile_phone+"',"+country+","+city+","+district+",'"+cp_id+"','"+street+"','"+num_street+"')")
    return idUser



def insertarPassWordYCon(avatarid,email,password,histEmails,histPassword,secureCode):
    insertData('avatar_credentials','avatar_info_id, email, password, hist_email, hist_pass, secure_code',"("+avatarid+",'"+email+"','"+password+"','"+str(histEmails)+"','"+str(histPassword)+"','"+secureCode+"')")





# @user_register.before_request
# def verify_token():
#     token=request.headers['Authorization'].split(' ')[1]
#     return validate_token(token,output=False)
#     if token == '123123':
#         return True
#     else:
#         return 'token invalido'


@user_register.route('/register',methods=['POST'])
def addProduct():

    dataSended=request.json
    
    name = dataSended['name']
    name_2 = dataSended['name_2']
    lastname = dataSended['lastname']
    lastname_2 = dataSended['lastname_2']
    identification_type_id = dataSended['identification_type_id']
    identification = dataSended['identification']
    age = dataSended['age']
    area_code = dataSended['area_code']
    house_phone = dataSended['house_phone']
    mobile_phone = dataSended['mobile_phone']
    countries_id = dataSended['countries_id']
    city_id = dataSended['city_id']
    district_id = dataSended['district_id']
    cp_id = dataSended['cp_id']
    street = dataSended['street']
    num_street = dataSended['num_street']
    email=dataSended['email']
    password=dataSended['password']

    print(email)

    # chequeo que el mail no exista
    checkEmail=buscar_id('avatar_credentials','id','email', "'"+email+"'")
    if checkEmail:
        return jsonify({"message":"Product Added Succesfully", "products":"No se puede registrar un Mail que YA EXISTE"})
    else:
        try:
            idUser=insertarDataRegistro(
                                name,
                                name_2,
                                lastname,
                                lastname_2,
                                identification_type_id,
                                identification,
                                age,
                                area_code,
                                house_phone,
                                mobile_phone,
                                countries_id,
                                city_id,
                                district_id,
                                cp_id,
                                street,
                                num_street
                                )
            avatar_id=idUser
            print(avatar_id)
            # introdusco en credential tambien
            insertarPassWordYCon("'"+str(idUser)+"'",str(email),str(password),'[''lemos@gmail.com'',''juana@gmail.com'']','[''lemos@gmail.com'',''juana@gmail.com'']','12321')

            jsonData=write_token(
                data={
                    "name":name,
                    "id":avatar_id,
                    }
                    )
            print(jsonData)

            return jsonify({
                "message":"User Register Succesfully",
                "succefully":True,
                'token':str(jsonData) 
                })
        except:
            return jsonify({
                "message":"User can NOT Register Succesfully",
                "succefully":False,
                })


