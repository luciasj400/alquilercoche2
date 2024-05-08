import 'dart:io';

import 'package:mysql1/mysql1.dart';

import 'database.dart';

class Vehiculo{
  int? idvehiculo;
  String? nombre;
  int? capacidad;

Vehiculo();

 Vehiculo.fromMap(ResultRow map){
    this.idvehiculo= map['idvehiculo'];
    this.nombre = map['nombre'];
    this.capacidad = map ['capacidad'];
}

all() async{
  var conn = await Database().conexion();
  try {
    var listado = await conn.query('SELECT * FROM vehiculos ');
    List vehiculos = listado.map((row) => Vehiculo.fromMap(row)).toList();
    return vehiculos;
  } catch(e) {
    print(e);
  } finally {
    await conn.close();

  }
 }
 getVehiculo(idvehiculo)async{
    var conn = await Database().conexion();
    try{
      var resultado = await conn.query("SELECT * FROM vehiculos WHERE idvehiculo = ?",[idvehiculo]);
      Vehiculo vehiculos = Vehiculo.fromMap(resultado.first);
      return vehiculos;
    } catch(e){
      print(e);
    }finally{
      await conn.close();
    }
  }
insertarCoche()async{
  var conn = await Database().conexion();
  try{
    await conn.query('INSERT INTO vehiculos (nombre, capacidad) VALUES (?,?)' , [nombre,capacidad]);
    print ('Coche insertado correctamente');
  } catch (e) {
    print(e);
  } finally {
    await conn.close();
  }
 
  }

  
  }