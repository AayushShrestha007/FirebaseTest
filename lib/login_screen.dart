
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login() async {
    try {
      String email = emailController.text.trim();

      String password = passwordController.text.trim();

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch(ex){
      log(ex.code.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),


      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter user name',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Password',
              ),
            ),
            SizedBox(
              width: 30,
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){

            login();
              },
              child: Text("Login"),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context,"/register");

                },
                child: Text("Register"),
            ),
          ],
        ),
      )
    );
  }
}
