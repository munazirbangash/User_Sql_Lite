import 'package:flutter/material.dart';
import 'package:sql_lite/list_screen.dart';
import 'dart:convert';
import 'package:sql_lite/model/model.dart';
import 'package:sql_lite/databasehelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late String name;
  late int age;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Add Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const  InputDecoration(
                    hintText: "Add User",
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Please provide a name";
                    }
                    name = value ;
                    return null;
                  },
                ),
                 const SizedBox(height: 10,),
                TextFormField(
                  decoration:  const InputDecoration(
                    hintText:"Add Age"
                  ),
                  validator: (String? value){
                    if(value == null || value.isEmpty){
                      return "Please provide age";
                    }
                    age = int.parse(value);
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: () async {
                 if(formkey.currentState!.validate()){
                  var user = User(name:name,age:age);
                  var dbHelper = DatabaseHelper.instance;
                  int? result = await dbHelper.insertUser(user);
                  if(result !> 0){
                    Fluttertoast.showToast(msg:"user inserted");
                  }
               }
             },
                 child: const Text(
                    "Save"
            )),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ListScreen();
                  }));
                }, child: const Text("View")),
              ],
        ),
          ),
      ),
    ),
    );
  }
}
