import "package:flutter/material.dart";
import "package:path/path.dart";
import "package:prueba_uno/ui/pages/remember_password.dart";
import 'package:prueba_uno/ui/pages/main_page.dart';
import "package:sqflite/sqflite.dart";

class EmailLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmailLoginPageState();
  }
}

class EmailLoginPageState extends State<EmailLoginPage> {
  Future<void>? initDatabase;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;
  late TextEditingController _controller2;

  late Database _database;

  @override
  initState() {
    super.initState();
    _controller = TextEditingController(text: '');
    _controller2 = TextEditingController(text: '');
    initDatabase = _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'usuarios.db');

      _database = await openDatabase(path);

      print('Database opened successfully');
    } catch (e) {
      print('Error opening the database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/Planta.png",
                width: 250,
                height: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Inicia sesión con correo",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen),
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.mail),
                        hintText: 'Ej. usuario@gmail.com',
                        label: Text('Email'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'El campo email es obligatorio';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: _controller2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Contraseña'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return 'El campo de contraseña es obligatorio';
                        }
                        return null;
                      }),
                ]),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                child: Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(
                      color: Colors.lightGreen[700],
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RememberPassword()));
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _verifyCredentials(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text("Iniciar sesión"),
              ),
            ]),
          ),
        ));
  }

  Future<void> _verifyCredentials(BuildContext context) async {
    if (initDatabase == null) {
      print('Esperando la inicialización de la base de datos...');
      return; // Evitar verificaciones hasta que la base de datos esté inicializada
    }

    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Obtener valores de los controladores
        String email = _controller.text;
        String password = _controller2.text;

        // Imprimir las credenciales antes de la consulta
        print('Email: $email, Password: $password');

        // Imprimir todos los registros en la base de datos
        List<Map<String, dynamic>> allRecords =
            await _database.rawQuery('SELECT * FROM user');
        print('Registros en la base de datos:');
        for (var record in allRecords) {
          print(record);
        }

        // Realizar la consulta SQL
        List<Map<String, dynamic>> results = await _database.rawQuery(
          'SELECT * FROM user WHERE email = ? AND password = ?',
          [email, password],
        );

        // Verificar si se encontraron resultados
        if (results.isNotEmpty) {
          print('Credenciales válidas. Usuario encontrado: ${results.first}');
          // Redirigir a main_page.dart
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          print('Credenciales inválidas. Usuario no encontrado.');
          // Mostrar un SnackBar con un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Usuario o contraseña incorrectos. Verifica tus datos.'),
              duration: Duration(seconds: 3),
            ),
          );
          // Aquí puedes manejar el inicio de sesión fallido
        }
      } catch (e) {
        print('Error al verificar las credenciales: $e');
        // Aquí puedes manejar cualquier error que ocurra durante la verificación
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
