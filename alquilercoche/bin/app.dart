import 'dart:io';
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
        await loginAdministrador();
        stdout.writeln('Bienvenido');
        break;
      case 4:
        await loginUsuario();
        stdout.writeln('Bienvenido a la app');
        break;
    }
  }

  int? parsearOpcion(String respuesta) {
    return int.tryParse(respuesta);
  }

  bool _resultadoNoValido ( var opcion) => opcion == null || opcion!= 1 && opcion!= 2 && opcion!=3 && opcion!=4;
 

  otroMenu(Usuario usuario) async{
    int? opcion;
    String? nombre = usuario.nombre;
    stdout.writeln('Hola, $nombre.');
    do {
      stdout.writeln('¿Que coche necesitas alquilar?');
      String respuesta = stdin.readLineSync() ?? 'E';
      opcion = int.tryParse(respuesta);
    } while (opcion == null);
      
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
      otroMenu(resultado);
    }
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
    }
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


}