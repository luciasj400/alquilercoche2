import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Administrador{
  String? nombre;
  int? idadministrador;
  String? password;


Administrador();

 Administrador.fromMap(ResultRow map){
    this.idadministrador = map['idadministrador'];
    this.nombre = map['nombre'];
    this.password = map ['password'];
}


loginAdministrador() async{
var conn = await Database().conexion();
try{
  var resultado = await conn.query('SELECT * FROM administrador WHERE nombre = ?',[this.nombre]);
  Administrador administrador = Administrador.fromMap(resultado.first);
  if(this.password == administrador.password) {
    return administrador;
  } else 
    return false;
} catch(e){
  print(e);
  return false;
} finally {
  await conn.close();
}
}

insertarAdministrador() async {
  var conn = await Database().conexion();
  try{
  await conn.query('INSERT INTO administrador (nombre, password) VALUES (? , ?)' , [nombre,password]);
  print ('administrador insertado correctamente');
} catch (e) {
  print (e);
} finally {
  await conn.close(); 
  }
}

 all() async{
  var conn = await Database().conexion();
  try {
    var listado = await conn.query('SELECT * FROM administrador');
    List <Administrador> administradores = listado.map((row) => Administrador.fromMap(row)).toList();
    return administradores;
  } catch(e) {
    print(e);
  } finally {
    await conn.close();

  }
 }
}