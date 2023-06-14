import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController cPasswordController= TextEditingController();

  void createAccount() async{
  String email = emailController.text.trim();
  String password = passwordController.text.trim();
  String cPassword = cPasswordController.text.trim();

  if(email=="" || password =="" || cPassword==""){
    log("please fill everything");
  }
  else if(password!=cPassword){
    log("password must match");
  }

  else {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
        if(userCredential.user!=null){
          Navigator.pop(context);
        }
      log("user created");
    }
    on FirebaseAuthException catch(ex){
      log(ex.code.toString());
    }
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email Address'
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
                TextField(
                  controller: cPasswordController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Confirm password'
                  ),
                ),

                ElevatedButton(
                    onPressed: (){
                      createAccount();

                    },
                    child: Text("Sign Up"))
              ],
            )
          ],
        ),

      )
    );
  }
}
