import 'package:mysql1/mysql1.dart';

import 'Database.dart';

class Usuario {
String? nombre;
int? idusuario;
String? password;


Usuario();

 Usuario.fromMap(ResultRow map){
    this.idusuario = map['idusuario'];
    this.nombre = map['nombre'];
    this.password = map ['password'];
}


loginUsuario() async{
var conn = await Database().conexion();
try{
  var resultado = await conn.query('SELECT * FROM usuarios WHERE nombre = ?',[this.nombre]);
  Usuario usuario = Usuario.fromMap(resultado.first);
  if(this.password == usuario.password) {
    return usuario;
  } else 
    return false;
} catch(e){
  print(e);
  return false;
} finally {
  await conn.close();
}
}

insertarUsuario() async {
  var conn = await Database().conexion();
  try{
  await conn.query('INSERT INTO usuarios(nombre, password) VALUES (? , ?)' , [nombre,password]);
  print ('usuario insertado correctamente');
} catch (e) {
  print (e);
} finally {
  await conn.close(); 
  }
}

 all() async{
  var conn = await Database().conexion();
  try {
    var listado = await conn.query('SELECT * FROM usuarios');
    List<Usuario> usuarios = listado.map((row) => Usuario.fromMap(row)).toList();
    return usuarios;
  } catch(e) {
    print(e);
  } finally {
    await conn.close();

  }
 }
}