import 'package:project_lib_beta_02/Classes/Book.dart';
import 'package:sqflite/sqflite.dart';
import 'databaseConfig.dart';
class crud{

  Future<Database?> getDatabase(Database db) async {
    var databasec = DbConfig();
    Database? dab = await databasec.db;
    return dab;
  }

  Future<List<Book>> getBooks() async{
    var databasec = DbConfig();
    Database? db = await databasec.db;
    var result = await db?.query("book");
    return List.generate(result!.length, (index) => Book.fromObject(result[index]));

  }
  Future<int> insertBook(Book book) async {
    var databasec = DbConfig();
    Database? db = await databasec.db;
    var result = await db?.insert("book", book.toMap());
    return result!;


  }
  Future<int> deleteBook(int id) async {
    var databasec = DbConfig();
    Database? db = await databasec.db;
    var result = await db?.rawDelete("delete from book where id= $id");
    return result!;
  }

  Future<int> updateBook(Book book) async {
    var databasec = DbConfig();
    Database? db = await databasec.db;
    var result = await db?.update("book", book.toMap(),where:"id=?",whereArgs: [book.id] );
    return result!;


  }
}