import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/UsersModel.dart';

class userRepo{
  final _firestore= FirebaseFirestore.instance.collection("users").withConverter(
      fromFirestore: (snapshot,_){
    return UsersModel.fromFirebaseSnapshot(snapshot);
  },
      toFirestore: (UsersModel model,_)=> model.toJson());

  Future<dynamic> updateUser(String emails, UsersModel data) async{
      try{

  await _firestore.doc(emails).set(data);
  } catch(e){
        print(e);
  }

}


  Future<dynamic> addUser(UsersModel data) async{
    try{
      await _firestore.add(data);
    } catch(e){
      print(e);
    }

  }


  Future<List<QueryDocumentSnapshot<UsersModel>>> fetchAllUsers() async{
    try{
      final result = (await _firestore.get()).docs;
      return result;
    } catch(e){
      return [];
    }
  }

}