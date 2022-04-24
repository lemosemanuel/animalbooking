import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'url.dart' as urlDirecction;


class AuthService extends ChangeNotifier{
  // final String _baseUrl='identitytoolkit.googleapis.com';
  final String _apiToken=' AIzaSyDt80l6AdGNl2iW2SpVoSdk7hwBqHwQYEg ';
  final storage= new FlutterSecureStorage();

  Future login(String name,String password)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/auth'));
      request.body = json.encode({
        "email":name,
        "password":password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson}");

      if (respuestaJson["succefully"]==true){
        final storage = new FlutterSecureStorage();
        storage.write(key: 'jwt', value: respuestaJson["token"] );

        return true;
      }else{
        return false;
      }
  }




  Future logout()async{
    // delete token from storage
    await storage.delete(key: 'idToken');
    return null;
  }

  Future<String>readToken()async{
    return await storage.read(key: 'idToken')??'';
  }



    Future checkEmail(String email)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/checkEmail'));
      request.body = json.encode({
        "email": email
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson}");

      if (respuestaJson["succefully"]==true){
        return false;
      }else{
        return true;
      }
    } 


    Future register(String name,String name_2,String lastname,String lastname_2,String identification_type_id,String identification,String age,String area_code,String house_phone,String mobile_phone,String countries_id,String city_id,String district_id,String cp_id,String street,String num_street,String email,String password,)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${urlDirecction.url}api/register'));
      request.body = json.encode({
        "name":name,
        "name_2":name_2,
        "lastname":lastname,
        "lastname_2":lastname_2,
        "identification_type_id":identification_type_id,
        "identification":identification,
        "age":age,
        "area_code":area_code,
        "house_phone":house_phone,
        "mobile_phone":mobile_phone,
        "countries_id":countries_id,
        "city_id":city_id,
        "district_id":district_id,
        "cp_id":cp_id,
        "street":street,
        "num_street":num_street,
        "email":email,
        "password":password
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson}");

      if (respuestaJson["succefully"]==true){
          final storage = new FlutterSecureStorage();
          storage.write(key: 'jwt', value: respuestaJson["token"]);
        return respuestaJson["token"];
      }else{
        return "";
      }
  }


}