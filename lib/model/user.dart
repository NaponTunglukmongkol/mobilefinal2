import 'package:sqflite/sqflite.dart';

final String tableUser = "user";
final String columnId = "_id";
final String columnname = "name";
final String columnage = "age";
final String columnuserid = "userid";
final String columnpassword = "password";

class User {
  int id;
  String name;
  int age;
  String userid;
  String password;

  User();

  User.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.name = map[columnname];
    this.age = map[columnage];
    this.userid = map[columnuserid];
    this.password = map[columnpassword];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnname: name,
      columnage: age,
      columnuserid: userid,
      columnpassword: password
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }
}

class UserProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableUser (
        $columnId integer primary key autoincrement,
        $columnname text not null,
        $columnage interger not null,
        $columnuserid text not null,
        $columnpassword text not null
      )
      ''');
    });
  }

  Future<User> insert(User user) async {
    db.insert(tableUser, user.toMap());
    return user;
  }

  Future<User> getUser(int id) async {
    List<Map> map = await db.query(tableUser,
        columns: [columnId, columnage, columnname, columnuserid, columnpassword],
        where: "$columnId = ?",
        whereArgs: [id]);

    if (map.length > 0) {
      return new User.formMap(map.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    return db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future close() => db.close();
}