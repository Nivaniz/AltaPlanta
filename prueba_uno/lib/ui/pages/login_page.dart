import "package:flutter/material.dart";
import "package:prueba_uno/ui/pages/email_login_page.dart";
import "package:prueba_uno/ui/pages/register_page.dart";
import "package:social_login_buttons/social_login_buttons.dart";

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
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
        color: Colors.white, // Establece el color de fondo del Scaffold
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/Planta.png",
              width: 250,
              height: 250,
            ),
            const Text(
              "Bienvenido a Alta Planta",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            ),
            Column(
              children: [
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 16,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  child: Text(
                    "Iniciar sesión con correo",
                    style: TextStyle(
                        color: Colors.lightGreen[700],
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailLoginPage()));
                  },
                ),
                const Text("o"),
                GestureDetector(
                  child: Text(
                    "Crear cuenta",
                    style: TextStyle(
                        color: Colors.lightGreen[700],
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
