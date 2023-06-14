import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/Repository/userRepo.dart';
import 'package:firebase_test/models/UsersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List<QueryDocumentSnapshot<UsersModel>> userData=[];
  Future<void> fetchData() async{
    try{
      final response = await userRepo().fetchAllUsers();
      setState(() {
        userData= response;
      });
    }
    catch(e){
      print(e);
    }
  }


  void _showDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Delete"),
        content: Text("Are you sure you want to delete this product?"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Delete")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
            // delete(_id);
          }, child: Text("Cancel")),
        ],
      );
    });
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void saveUser(){
    String names = nameController.text.trim();
    String emails = emailController.text.trim();
    final data= UsersModel(
        name: names,
        email: emails,
    );
    userRepo().addUser(data);
  }


  void logOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil((context), (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/login');
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: Text("home"),
        actions: [
          IconButton(
              onPressed:(){
                logOut();
              },
            icon: Icon(Icons.exit_to_app),

               )
        ]
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Name"
              ),
            ),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Email"
              ),
            ),

            ElevatedButton(
                onPressed: (){
                  saveUser();
                },
                child: Text("Save"),
            ),

            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/update',arguments: emailController.text);
              },
              child: Text("Update"),
            ),




            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("users").
              snapshots(),
              builder: (context, snapshot)  {
                    if(snapshot.connectionState==ConnectionState.active){
                      if(snapshot.hasData && snapshot.data!=null){
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,index){
                                      Map<String, dynamic> userMap= snapshot.data!.docs[index].data() as Map<String, dynamic>;


                                      return ListTile(
                                        title: Text(userMap['name']),
                                        subtitle: Text(userMap['email']),

                                      );
                                      },
                                    ),
                                  );
                      }
                      else{
                        return Text("no data");
                      }
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
              }
            ),
          ],
        ),
      )
    );
  }
}
