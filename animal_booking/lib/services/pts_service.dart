import 'package:animal_booking/models/modes.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class PetsService extends ChangeNotifier{
  final String _baseUrl='fluttervarios-a808e-default-rtdb.firebaseio.com';
  final List<Pet> pets=[];
  bool isLoading=true;
  bool isSaving=false;
  late Pet selectedPet;

  final storage = new FlutterSecureStorage();
  File? newPictureFile;

  PetsService(){
    this.loadPets();
  }

  Future <List<Pet>> loadPets()async{
    this.isLoading=true;
    notifyListeners();
    final url=Uri.https(_baseUrl, 'animals.json',
    // {
    //   'auth':await storage.read(key: 'idToken')??''
    // }
    );
    final resp= await http.get(url);
    final Map<String,dynamic> petsMap=json.decode(resp.body);
    print(petsMap);


    petsMap.forEach((key, value) {
      final tempPet=Pet.fromMap(value);
      tempPet.id=key;
      this.pets.add(tempPet);
    });

    this.isLoading=false;
    notifyListeners();
    return this.pets;

  }

    Future saveOrCreatePet (Pet pet)async{
    isSaving=true;
    notifyListeners();

    if(pet.id==null){
      await this.createPet(pet);
    }else{
      await this.updatePet(pet);
    }

    isSaving=false;
    notifyListeners();
  }

    Future<String>createPet(Pet pet)async{
    final url=Uri.https(_baseUrl, 'animals.json');
    final resp= await http.post(url,body: pet.toJson());
    final decodeData=json.decode(resp.body);

    // firebase en el decodeData me devuelve el id
    pet.id=decodeData['name'];
    this.pets.add(pet);

    return pet.id!;
  }


  Future<String>updatePet(Pet pet)async{
    final url=Uri.https(_baseUrl, 'animals/${pet.id}.json');
    final resp= await http.put(url,body: pet.toJson());
    final decodeData=resp.body;
    // print(decodeData);

    // indice del producto que voy a actualizar
    final index= this.pets.indexWhere((element) => element.id==pet.id);
    this.pets[index]=pet;

    return '';
  }

  void updateSelectedPetImage(String path){
    this.selectedPet.picture=path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future <String?>uploadImage()async{
    if (this.newPictureFile == null) return null;
    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/elemos/image/upload?upload_preset=t4g2joqv');
    final imageUploadRequest= http.MultipartRequest(
      'POST',
      url
    );

    // adjunto el archivo
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    // disparo la peticion
    final streamResponse=await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode !=201){
      print('algo salio mal');
      print(resp.body);
      return null;
    }
    this.newPictureFile= null;
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }

}

