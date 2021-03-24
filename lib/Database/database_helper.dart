import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/Models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;
  final String tableUser = "User";
  final String columnName = "name";
  final String columnUserName = "username";
  final String columnPassword = "password";
  final String columnPhone = "phone";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE User(id INTEGER PRIMARY KEY, fname TEXT, username TEXT, password TEXT, lname TEXT, phone TEXT, address TEXT, gender TEXT, dob TEXT, picture TEXT)",
    );
    print("Table is created");
  }

  //insertion
  Future<int> saveUser(Person user) async {
    var dbClient = await db;
    // print(user.name);
    List<Map> listl = await dbClient.rawQuery('SELECT * FROM User');
    print(listl);
    List<Map> maps = await dbClient
        .rawQuery('SELECT * FROM User WHERE username=?', ['${user.username}']);
    // dbClient.query(tableUser,
    //     columns: [columnUserName, columnPassword],
    //     where: "$columnUserName = ? and $columnPassword = ?",
    //     whereArgs: [user.username, user.password]);
    print(maps);
    if (maps.length > 0) {
      print('alresdy');

      return null;
    } else {
      int res = await dbClient.insert("User", user.toMap());
      List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
      print(list);
      return res;
    }
  }

  //deletion
  Future<int> deleteUser(Person user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future selectUser(String email) async {
    print('inside select User');
    // print("Select User");
    // print(user.username);
    // print(user.password);
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    List<Map> maps = await dbClient
        .rawQuery('SELECT * FROM User WHERE username=?', ['$email']);
    // dbClient.query(tableUser,
    //     columns: [columnUserName, columnPassword],
    //     where: "$columnUserName = ? and $columnPassword = ?",
    //     whereArgs: [user.username, user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      // Person user;
      // maps.toList();
      return maps[0];
    } else {
      return null;
    }
  }
  // Future<String> selectUser(String email, String pass) async {
  //   // print("Select User");
  //   // print(user.username);
  //   // print(user.password);
  //   print(email);
  //   print(pass);
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query(tableUser,
  //       columns: [columnUserName, columnPassword],
  //       where: "$columnUserName = ? and $columnPassword = ?",
  //       whereArgs: [email, pass]);
  //   print(maps);
  //   if (maps.length > 0) {
  //     print("User Exist !!!");
  //     return "1";
  //   } else {
  //     return "0";
  //   }
  // }
}
