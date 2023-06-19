import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sql_lite/model/model.dart';
import 'package:sql_lite/databasehelper.dart';
import 'package:sql_lite/update_user.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text("List Screen"),
      ),
      body: FutureBuilder<List<User>>(
        future: DatabaseHelper.instance.getUsers(),
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text("no record found "),);
            }
            else {
              List<User> users = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(12),
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      User user = users[index];
                      return Container(
                        width: 40,
                        height: 120,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.deepOrangeAccent),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.id.toString()),
                                Text(user.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Text(user.age.toString(),style: const TextStyle(fontSize: 18),),
                              ],
                            )
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: ()async {
                                  var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return UpdateUser(user: user);
                                  }));
                                  if (result == "update"){
                                    setState(() {

                                    });
                                  }

                                }, icon: const Icon(Icons.edit)),
                                IconButton(onPressed: (){
                                  showDialog(
                                    barrierDismissible: false,
                                      context: context, builder: (context){
                                      return  AlertDialog(
                                        title: const Text("Confirm Delete"),
                                        content: const Text("are you sure want to delete?"),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.of(context).pop();
                                            }, child: const Text("No")),
                                          TextButton(onPressed: ()async {
                                            Navigator.of(context).pop();
                                            int? result = await DatabaseHelper.instance.delete(user);
                                            if(result! > 0){
                                              Fluttertoast.showToast(msg:"user Deleted");
                                              setState(() {

                                              });
                                            }
                                          }, child: Text("Yes")),
                                        ],
                                      );

                                  }
                                );

                                },
                                    icon: Icon(Icons.delete)),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),);
          }
        }
      ),
      );
  }
}
