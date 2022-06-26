import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class Login extends StatefulWidget {
  final FirebaseAuth auth;

  const Login({
    Key? key,
    required this.auth,
  }) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginOrRegister(
      Future<String> Function({required String email, required String password})
          func) async {
    final String retVal = await func(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (retVal == "Success") {
      _emailController.clear();
      _passwordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(retVal),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const ValueKey("username"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Username"),
                  controller: _emailController,
                ),
                TextFormField(
                  key: const ValueKey("password"),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: "Password"),
                  controller: _passwordController,
                  obscureText: true,
                  onEditingComplete: () =>
                      loginOrRegister(Auth(auth: widget.auth).signIn),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  key: const ValueKey("signIn"),
                  onPressed: () =>
                      loginOrRegister(Auth(auth: widget.auth).signIn),
                  child: const Text("Sign In"),
                ),
                TextButton(
                  key: const ValueKey("createAccount"),
                  onPressed: () =>
                      loginOrRegister(Auth(auth: widget.auth).createAccount),
                  child: const Text("Create Account"),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
