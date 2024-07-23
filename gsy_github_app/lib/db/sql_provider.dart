import 'package:flutter/cupertino.dart';
import 'package:gsy_github_app/db/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDbProvider {
  bool isTableExist = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name ($columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDatabase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String? createSql) async {
    isTableExist = await SqlManager.isTableExist(name);
    if (!isTableExist) {
      Database? db = await SqlManager.getCurrentDatabase();
      return await db?.execute(createSql!);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExist) {
      await prepare(tableName(), tableSqlString());
    }

    return await SqlManager.getCurrentDatabase();
  }
}
