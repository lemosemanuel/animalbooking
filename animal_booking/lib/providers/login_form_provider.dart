import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
  GlobalKey<FormState>formKey=new GlobalKey<FormState>();

  String email='';
  String password='';

  // if press button i gonna swich _isLoading to true
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }

  // do the validation
  bool isValidForm(){
    return formKey.currentState?.validate()??false;
  }
}