import 'package:animal_booking/models/modes.dart';
import 'package:flutter/material.dart';

class PetFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Pet pet;

  PetFormProvider(this.pet);


  updateAvailability (bool value){
    this.pet.aviable= value;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate()??false;
  }
}