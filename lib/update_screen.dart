
import 'package:flutter/material.dart';

import 'Repository/userRepo.dart';
import 'models/UsersModel.dart';

// import 'Repos/productRepositery.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {





  String emailss="";
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final args= ModalRoute.of(context)?.settings.arguments;
      if(args!=null){
        setState(() {
          emailss=args.toString();
        });
        // fillData(args.toString());
      }
    });
        super.initState();
  }
  TextEditingController _userName = new TextEditingController();
  TextEditingController _userEmail= new TextEditingController();


  Future<void> update() async{
    try{
      String names = _userName.text.trim();
      String emails =  _userEmail.text.trim();
      final data= UsersModel(
        name: names,
        email: emails,
      );
      await userRepo().updateUser(emailss, data);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Updated")));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Screen"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(controller: _userName, decoration: InputDecoration(label: Text("Name")),),
            TextFormField(controller: _userEmail, maxLines: 5, decoration: InputDecoration(label: Text("Email")),),


            ElevatedButton(onPressed: (){
              update();
            }, child: Text("Update user"))
          ],
        ),
      ),
    );
  }
}