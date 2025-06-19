import 'package:ppkd_b2/study%20case/model/model_siswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper1 {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'siswa.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE siswa(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, umur INTEGER)',
        );
      },
        version:1,
    );
  }
  Future<void> insertSiswa(Siswa siswa) async {
    final db = await  DbHelper1.db();
    await db.insert(
      'siswa',
      siswa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Siswa>> getAllSiswa() async {
    final db = await DbHelper1.db();
    final List<Map<String, dynamic>> maps = await db.query('siswa');
    return List.generate(maps.length, (i) {
      return Siswa.fromMap(maps[i]);
    });
  }
  Future <void> deleteSiswa(int id) async {
    final db = await DbHelper1.db();
    await db.delete(
      'siswa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
