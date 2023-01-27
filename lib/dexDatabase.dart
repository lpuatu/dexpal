import 'package:sqflite/sqflite.dart';

loadDB() async {
  var database = await openDatabase(
    'databaseName.db',
    onCreate: (db, version) {},
    version: 1,
  );
  final db = await database;
  await db.execute(
      'CREATE TABLE pokeDex (name varchar, age int, address varchar);');
}
