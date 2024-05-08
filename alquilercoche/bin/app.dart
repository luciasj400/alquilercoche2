import 'dart:io';
import 'package:test/test.dart';

import 'administrador.dart';
import 'usuario.dart';
import 'vehiculo.dart';
import 'administrador.dart';

class Menu {
  imprimirmenu() async {
    int? opcion;
    do {
      stdout.writeln('''Elige una opcion:
        1-Crear administrador
        2-Crear Usuario
        3-Login administrador
        4-Login Usuario
        ''');
      String respuesta = stdin.readLineSync() ?? "E";
      opcion = parsearOpcion(respuesta);
    } while (_resultadoNoValido (opcion));
    switch (opcion) {
      case 1:
        crearAdministrador();
        break;
      case 2:
        crearUsuario();
        break;
      case 3:
        Administrador administrador = await loginAdministrador();
        stdout.writeln('Bienvenido');
        menuAdministrador(administrador);
        break;
      case 4:
        Usuario usuario = await loginUsuario();
        stdout.writeln('Bienvenido a la app');
        MenuUsuario(usuario);
        break;
    }
  }

  int? parsearOpcion(String respuesta) {
    return int.tryParse(respuesta);
  }

  bool _resultadoNoValido ( var opcion) => opcion == null || opcion!= 1 && opcion!= 2 && opcion!=3 && opcion!=4;
  bool _resultadonoValido ( var opcion) => opcion == null || opcion!= 1 && opcion!= 2;

  menuAdministrador( Administrador administrador) async{
    int? opcion;
    do{
      stdout.writeln('''Elige una opcion
       1-Insertar Coches
       2-Ver Coches 
       ''');
      String respuesta = stdin.readLineSync() ?? "E";
      opcion = parsearOpcion(respuesta);
    } while (_resultadonoValido (opcion));
    switch (opcion) {
      case 1:
      crearVehiculo();
      break;
      case 2:
      //listar los coches
    }
  }


  MenuUsuario (Usuario usuario) async{
    int? opcion;
    String? nombre = usuario.nombre;
    stdout.writeln('Hola, $nombre.');
    do {
      stdout.writeln('¿Que coches escoges de estos?');
      await listarVehiculo();
      String respuesta = stdin.readLineSync() ?? 'E';
      opcion = int.tryParse(respuesta);
    } while (opcion == null);
      Vehiculo vehiculo = Vehiculo();
      vehiculo = await vehiculo.getVehiculo(opcion);
      escogerVehiculo(vehiculo);


  }

  loginUsuario() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce tu nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu contraseña');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();

    if (resultado == false) {
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
    } else{
      return resultado;
    }
  }
   escogerVehiculo(vehiculo)async{
    stdout.writeln("el coche elegido es ${vehiculo.idvehiculo} y el modelo es ${vehiculo.nombre}");
  }
  
  loginAdministrador() async{
    Administrador administrador = new Administrador();
    stdout.writeln('Introduce tu nombre de administrador');
    administrador.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu contraseña');
    administrador.password = stdin.readLineSync();
    var resultado = await administrador.loginAdministrador();

    if (resultado == false) {
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
    } else return resultado;
  }

  crearUsuario() {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce un nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una contraseña');
    usuario.password = stdin.readLineSync();
    usuario.insertarUsuario();
  }

  crearAdministrador() {
    Administrador administrador = new Administrador();
    stdout.writeln('Introduce un nombre de administrador');
    administrador.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una contraseña');
    administrador.password = stdin.readLineSync();
    administrador.insertarAdministrador();
  }

  crearVehiculo() {
    Vehiculo vehiculo = new Vehiculo();
    stdout.writeln('Introduce un coche');
    vehiculo.nombre = stdin.readLineSync();
    stdout.writeln('Introduce la capacidad de ese coche');
    vehiculo.capacidad = int.tryParse(stdin.readLineSync() ?? 'e') ?? 0;
    vehiculo.insertarCoche();
  }

  listarVehiculo() async{
    List<Vehiculo> listadoVehiculos = await Vehiculo().all();
    for (Vehiculo elemento in listadoVehiculos){
      stdout.writeln("${elemento.idvehiculo} - ${elemento.nombre} - ${elemento.capacidad}");
    }
    return listadoVehiculos;
  }

}