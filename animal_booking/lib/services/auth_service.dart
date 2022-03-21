import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String _baseUrl='identitytoolkit.googleapis.com';
  final String _apiToken=' AIzaSyDt80l6AdGNl2iW2SpVoSdk7hwBqHwQYEg ';
  final storage= new FlutterSecureStorage();

  Future<String?> createUser(String email,String password)async{
    final Map<String, dynamic>authData={
      'email':email,
      'password':password,
      'returnSecureToken':true
    };

    final url=Uri.https(_baseUrl, '/v1/accounts:signUp',{
      'key':_apiToken
    });

    final resp = await http.post(url,body:json.encode(authData));
    final Map<String, dynamic> decodeResp= json.decode(resp.body);

    // if the user can be create the api return a token

    if(decodeResp.containsKey('idToken')){
      await storage.write(key: 'idToken', value: decodeResp['idToken']);
      return null;
    }else{
      return decodeResp['error']['message'];
    }
  }

  Future<String?> login(String email,String password)async{
    final Map<String, dynamic>authData={
      'email':email,
      'password':password,
      'returnSecureToken':true

    };

    final url=Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',{
      'key':_apiToken
    });

    final resp = await http.post(url,body:json.encode(authData));
    final Map<String, dynamic> decodeResp= json.decode(resp.body);

    // print(decodeResp);
    // return 'Error en el login';

    // si se registra me devuelve un token... lo tengo que guardar en el storage
    if (decodeResp.containsKey('idToken')){
      // guardo el token en el storage
      await storage.write(key: 'idToken', value: decodeResp['idToken']);
      // return decodeResp['idToken'];
      return null;

    }else{
      return decodeResp['error']['message'];
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
}