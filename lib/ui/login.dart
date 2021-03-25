import 'package:fbejemplo/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product DB',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Container(
            margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
            color: Colors.white,
            child: Center(
                child: Column(
              children: [
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                        border: OutlineInputBorder(),
                        labelText: 'email')),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        hoverColor: Colors.white)),
                Container(
                  padding: new EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (emailController.text.trim() != '' &&
                          passwordController.text.trim() != '') {
                        try {
                          context.read<AuthenticationService>().signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        } catch (e) {
                          print('email o contrasenia');
                        }
                      }
                    },
                    child: Text("Sign in"),
                  ),
                )
              ],
            ))),
      ),
    );
    //
  }
}
