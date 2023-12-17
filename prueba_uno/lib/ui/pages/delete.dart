/*
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> openDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'usuarios.db');
    _database = await openDatabase(path);
  }

  Future<void> deleteAllUsers() async {
    await _database.delete('user');
  }

  Future<void> deleteUsers(List<String> namesToDelete) async {
    try {
      await openDatabase();
      await _database.delete('user', where: 'nombre IN (${List.filled(namesToDelete.length, '?').join(', ')})', whereArgs: namesToDelete);
      print('Registros eliminados correctamente');
    } catch (e) {
      print('Error al eliminar registros: $e');
    }
  }
}

void main() async {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<String> namesToDelete = ['Nirv', 'Pepe', 'nirvana'];
  await _databaseHelper.deleteUsers(namesToDelete);
}

*/