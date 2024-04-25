import 'package:mysql1/mysql1.dart';

class Database {
  
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  
  instalacion() async {
  var settings = ConnectionSettings(
    host: this._host,
    port: this._port,
    user: this._user,
  );
  
  var conn = await MySqlConnection.connect(settings);
  try{
    await crearDB (conn);
    await creartablausuario (conn);
    await creartablavehiculo(conn);
    await creartablaAdministrador(conn);
    await conn.close();
  } catch(e){
    print(e);
  } finally{
    await conn.close();
  }
}
  
  crearDB (conn) async {
    await conn.query ( 'CREATE DATABASE IF NOT EXISTS alquilerdb');
    await conn.query ('USE alquilerdb');
    print ('Conectado a alquilerdb');

  }
  creartablausuario (conn)async {

     await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
      idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL UNIQUE,
      password VARCHAR(10) NOT NULL
    )''');
    print ('Tabla usuarios creada');

  }
  Future<MySqlConnection> conexion() async{
 var settings = ConnectionSettings(
    host: 'localhost', 
    port: 3306,
    user: 'root',
    db: 'alquilerdb'
  );
  return await MySqlConnection.connect(settings);
  }

  creartablavehiculo (conn)async {

     await conn.query('''CREATE TABLE IF NOT EXISTS vehiculos(
      idvehiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL UNIQUE,
      fechaAlquiler VARCHAR (50) NOT NULL,
      capacidad INT NOT NULL
    )''');
    print ('Tabla vehiculo creada');

  }

  creartablaAdministrador (conn)async {
    
     await conn.query('''CREATE TABLE IF NOT EXISTS administrador(
      idadministrador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL UNIQUE,
      password VARCHAR(10) NOT NULL
    )''');
    print ('Tabla administrador creada');
     

  }
}