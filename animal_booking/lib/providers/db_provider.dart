


import 'package:animal_booking/models/modes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DBProvider{
  static Database? _database;

  // creo la instancia
  static final DBProvider db= DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    // si ya existe devolver la misma base de datos
      if (_database != null ) return _database!;
      // sino voy a crear la base de datos
      _database = await initDB();
      return _database!;
    }

  Future<Database>initDB()async{
    // PATH DONDE ALMACENAREMOS LA BASE DE DATOS
    Directory documentsDirectory= await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,'ScansDB.db');
    print(path);

    // crear base de datos
    return await openDatabase(

      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async{
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        );
        ''');
      },
    );
    
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan)async{
    final id= nuevoScan.id;
    final tipo= nuevoScan.tipo;
    final valor= nuevoScan.valor;
    // hago el getter
    final db= await database;
    
    final res=await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor')
    ''');
    print(res);
    return res;
  }

  // Future<int> nuevoScan (ScanModel nuevoScan)async{
  //   final db= await database;
  //   final res = await db.insert('Scans', nuevoScan.toJson() );
  //   return res;
  // }

  // obtener registros
  Future getScanById(int id) async {
    final db= await database;
    final res= await db.query('Scans',where: 'id=?',whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    } else {
      return null;
    }
  }

  Future getTodosLosScans() async {
    final db= await database;
    final res= await db.query('Scans');

    if (res.isNotEmpty) {
      return res.map((e) => ScanModel.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future getScansPorTipo(String tipo) async {
    final db= await database;
    final res= await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    if (res.isNotEmpty) {
      return res.map((e) => ScanModel.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  Future <int> updateScan(ScanModel nuevoScan)async{
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toMap(),where: 'id=?',whereArgs: [nuevoScan.id]);
    return res;
  }

  // borrar registros
  Future <int> deleteScan(int id)async{
    final db = await database;
    final res = await db.delete('Scans',where: 'id=?',whereArgs: [id]);
    return res;
  }
  // borro todos
  Future <int> deleteAllScan()async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}