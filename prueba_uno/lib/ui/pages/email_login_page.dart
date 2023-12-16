import "package:flutter/material.dart";
import "package:prueba_uno/ui/pages/remember_password.dart";

class EmailLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmailLoginPageState();
  }
}

class EmailLoginPageState extends State<EmailLoginPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controller;
  late TextEditingController _controller2;

  @override
  initState() {
    _controller = TextEditingController(text: '');
    _controller2 = TextEditingController(text: '');
    super.initState();
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
                "Crea tu cuenta",
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
                onPressed: () async {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text("Crear cuenta"),
              ),
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
