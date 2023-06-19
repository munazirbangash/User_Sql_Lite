import 'package:flutter/material.dart';
import 'package:sql_lite/databasehelper.dart';
import 'package:sql_lite/list_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sql_lite/model/model.dart';


class UpdateUser extends StatefulWidget {
  final User user;

  const UpdateUser({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late String name;
  late int age;

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Update User"),
      ),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
    child: Form(
    key: formkey,
    child: Column(
      children: [
        TextFormField(
          initialValue:widget.user.name,
          decoration: const InputDecoration(
            hintText: "Update Name"
          ),
          validator: (String? value){
            if(value == null || value.isEmpty){
              return "please enter user name";
            }
            name = value;
            return null;
          }
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
            initialValue:widget.user.age.toString(),
            decoration: const InputDecoration(
                hintText: "Update age"
            ),
            validator: (String? value){
              if(value == null || value.isEmpty){
                return "please enter user age ";
              }
              age  = int.parse(value);
              return null;
            }
        ),
        const SizedBox(height: 10,),
        ElevatedButton(onPressed: ()async {
          if(formkey.currentState!.validate()){
            var user = User(id:widget.user.id,name: name, age: age);
            var dbhelper = DatabaseHelper.instance;
            int? result = await dbhelper.update(user);

            if(result! > 0){
              Fluttertoast.showToast(msg: "User Updated");
              Navigator.pop(context,"update");
            }
          }

        }, child: const Text("Update")),

      ],
    )
    ),
    ),
  ),

    );
  }
}
