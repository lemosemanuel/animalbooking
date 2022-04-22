import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'url.dart' as urlDirecction;

class ListDropDown extends ChangeNotifier{

  Future getDropDown (String table_name)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/list_drop_down'));
      request.body = json.encode({
        "table_name": table_name
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson['list_drop_down']}");

      if (respuestaJson["succefully"]==true){
        return respuestaJson["list_drop_down"];
      }else{
        return false;
      }
  }


  Future getCountriesData(String typeLocation,String placeName)async{
          var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/countries_list_drop_down'));
      request.body = json.encode({
        typeLocation: placeName
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson['list_drop_down']}");

      if (respuestaJson["succefully"]==true){
        return respuestaJson["list_drop_down"];
      }else{
        return false;
      }
  }
  
}