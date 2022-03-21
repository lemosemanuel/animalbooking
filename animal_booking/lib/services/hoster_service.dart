import 'package:animal_booking/models/modes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HosterService extends ChangeNotifier{

  final String _baseUrl='fluttervarios-a808e-default-rtdb.firebaseio.com';
  final List<Hoster>hosters=[];
  bool isLoading=true;
  bool isSaving=true;
  late Hoster selectedHoster;

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

}