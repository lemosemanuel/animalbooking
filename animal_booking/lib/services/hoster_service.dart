import 'package:animal_booking/models/modes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'url.dart' as urlDirecction;



class HosterService extends ChangeNotifier{

  final String _baseUrl='fluttervarios-a808e-default-rtdb.firebaseio.com';
  final List<Hoster>hosters=[];
  bool isLoading=true;
  bool isSaving=true;
  late Hoster selectedHoster;

  dynamic id_hoster;

  HosterService(){
    this.loadHosters();
  }

  Future <List<Hoster>> loadHosters()async{
    this.isLoading=true;
    notifyListeners();
    final url= Uri.https(_baseUrl, 'hosters.json');
    final resp=await http.get(url);
    final Map<String,dynamic> hosterMap=json.decode(resp.body);
    // print(hosterMap);

    hosterMap.forEach((key, value) {
      final tempHost=Hoster.fromMap(value);
      tempHost.id=key;
      this.hosters.add(tempHost);
    });

    this.isLoading=false;
    notifyListeners();
    print(hosters);
    return this.hosters;
  }

  Future checkAviable(String start_day,String end_day,String pet_id,String city_id)async{
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('GET', Uri.parse('${urlDirecction.url}api/resume_data_house'));
      request.body = json.encode({
        "start_day":start_day,
        "end_day":end_day,
        "pet_id":pet_id,
        "city_id":city_id
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print (await response.stream.bytesToString());
      String respuesta = await response.stream.bytesToString();
      var respuestaJson=json.decode(respuesta);
      // print("${respuestaJson}");

      if (respuestaJson["succefully"]==true){
        // print(respuestaJson);
        return respuestaJson["houses"];
      }else{
        return "";
      }
  }


}