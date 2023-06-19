import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_lite/model/model.dart';

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get databse async{
    _database ??= await initializeDatabase();
    return _database;
  }
  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/user.db';

    var userDatabase = await openDatabase(path, version: 1,onCreate: _createDb,);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create Table tbl_user(id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                     name TEXT,
                                                     age INTEGER)'''
    );
  }

  Future<int?>insertUser (User user) async {
    Database? db = await instance.databse;
    int? result = await db?.insert('tbl_user', user.toMap());
    return result;
  }
  Future<List<User>> getUsers() async {
    List<User> users = [];
    Database? db = await instance.databse;
    List<Map<String,Object?>>? mapValues = await db?.query('tbl_user');
    for(var userMap in mapValues!){
      User user = User.fromMap(userMap);
      users.add(user);
    }
    return users;

  }
  Future<int?> delete (User user ) async {
    Database? db =  await instance.databse;
    int? result = await db?.delete ("tbl_user", where: "id=?", whereArgs:[user.id]);
    return result;

  }

  Future<int?> update (User user ) async {
    Database? db =  await instance.databse;
    return await  db?.update ("tbl_user",user.toMap(), where: "id=?", whereArgs:[user.id]);


  }

}