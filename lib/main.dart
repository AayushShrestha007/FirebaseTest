

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/register_screen.dart';
import 'package:firebase_test/home.dart';
import 'package:firebase_test/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_screen.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore _firestore= FirebaseFirestore.instance;
  // Map<String, dynamic> data={
  //   "name": "Hello",
  //   "email": "Hello2@gmail.com"
  // };
  // _firestore.collection("users").doc("add-your-id").update({
  //   "emaisl":"newemail@gmail.com"
  // });
  // // DocumentSnapshot snapshot= await FirebaseFirestore.instance.collection('users').
  // //     doc("7zxSK0e09Lvyw3OmaN4P").get();

  await _firestore.collection("users").doc("add-your-id").delete();
  QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('users').get();

  // log(snapshot.data().toString());
  for( var i in snapshot.docs){
    log(i.data().toString());
  }
  //
  runApp(MaterialApp(


    initialRoute: (FirebaseAuth.instance.currentUser!=null) ? '/home' : '/login',
    routes: {
      '/login':(context)=> login(),
      '/register':(context)=> register(),
      '/home': (context)=> home(),
      '/update':(context)=> UpdateScreen(),
    },
  ));
}



