import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConfig  {
   Database? _db;

  Future<Database?> get db async{
    if(_db ==null)
      _db = await setupDb();
    
    return _db;
    
  }

  Future<Database> setupDb() async{
     String dbPath = join(await getDatabasesPath(),"library.db");
     var libDb = await openDatabase(dbPath,version: 1,onCreate: createDb);
     return libDb;

  }

  void createDb(Database db, int version) async {
    await db.execute("create table book(id integer primary key AUTOINCREMENT,name text,author text,topic text,pageNumber integer)");
  }
}