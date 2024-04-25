import 'Database.dart';
import 'Usuario.dart';
import 'dart:io';
import 'app.dart';

main() async {
  Database database = new Database();
  await database.instalacion();
  Menu().imprimirmenu();

}