import 'package:flutter/material.dart';
class User{
  int? id;
  late String name;
  late int age;


  User({
    this.id,
    required this.name,
    required this.age,

});
  Map<String, dynamic>toMap(){
    return{
      'id': id,
      'name': name,
      'age' : age,
    };
  }
  User.fromMap(Map <String,dynamic>map)
  {
    id = map['id'];
    name = map['name'];
    age = map['age'];
  }
}

