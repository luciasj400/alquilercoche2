import 'package:mysql1/mysql1.dart';

class Vehiculo{
  int? idvehiculo;
  String? nombre;
  String? fechaAlquiler;
  int? capacidad;

Vehiculo();

 Vehiculo.fromMap(ResultRow map){
    this.idvehiculo= map['idvehiculo'];
    this.nombre = map['nombre'];
    this.fechaAlquiler = map ['fechaAlquiler'];
    this.capacidad = map ['capacidad'];
}


}