

import 'package:animal_booking/models/modes.dart';
import 'package:animal_booking/providers/db_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ScanListProvider extends ChangeNotifier{
  List <ScanModel>scans =[];
  String tipoSelecccionado = 'http';


  Future <ScanModel>nuevoScan(String valor)async{
    final nuevoScan = new ScanModel(valor: valor);
    final id= await DBProvider.db.nuevoScanRaw(nuevoScan);

    // asignar el id de la base de datos al modelo
    nuevoScan.id=id;
    
    if (this.tipoSelecccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans()async{
    final scans= await DBProvider.db.getTodosLosScans();
    this.scans=[...scans];
    notifyListeners();
  }

  CargarScanPorTipo(String tipo)async{
    final scans= await DBProvider.db.getScansPorTipo(tipo);
    this.scans=[...scans];
    this.tipoSelecccionado=tipo;
    notifyListeners();
  }

  borrarTodos()async{
    await DBProvider.db.deleteAllScan();
    this.scans=[];
    notifyListeners();
  }
  borrarScanPorId(int id)async{
    await DBProvider.db.deleteScan(id);
    this. CargarScanPorTipo(this.tipoSelecccionado);
  }
   
}