import 'package:flutter/material.dart';

class IndexBottonNavigation extends ChangeNotifier{
  int _selectedIndex=0;

  int get selectedIndex{
    return this._selectedIndex;
  }
  set setSelectedIndex(int i){
    this._selectedIndex=i;
    notifyListeners();
  }
}