import 'dart:io';

import 'package:gsy_github_app/common/dao/user_dao.dart';
import 'package:gsy_github_app/model/User.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  static const _VERSION = 1;
  static const _NAME = "gsy_github_app_flutter.db";
  static Database? _database;

  /// 初始化
  static init() async {
    /// open the database
    var databasePath = await getDatabasesPath();
    var userRes = await UserDao.getUserInfoLocal();

    String dbName = _NAME;
    if (userRes != null && userRes.result) {
      User? user = userRes.data;
      if (user != null && user.login != null) {
        dbName = "${user.login!}_$_NAME";
      }
    }

    String path = databasePath + dbName;
    if (Platform.isIOS) {
      path = "$databasePath/$dbName";
    }

    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      /// when creating the db, create the table
      /// await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT,value INTEGER, num REAL)");
    });
  }

  /// 表是否存在
  static isTableExist(String tableName) async {
    await getCurrentDatabase();
    var res = await _database?.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.isNotEmpty;
  }

  /// 获取当前数据库对象
  static Future<Database?> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }

    return _database;
  }

  ///关闭
  static close() {
    _database?.close();
    _database = null;
  }
}
