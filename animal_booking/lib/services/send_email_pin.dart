import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'url.dart' as urlDirecction;


class SendEmailPin extends ChangeNotifier{
  Future sendPin(String email)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/send_email'));
      request.body = json.encode({
        "send_email":true,
        "email": email
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson}");

      if (respuestaJson["succefully"]==true){
        return json.decode(respuestaJson["code"]);
      }else{
        return false;
      }
  }
}