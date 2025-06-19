import 'package:ppkd_b2/study_kasus/model/model_peserta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper2 {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'Peserta.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE peserta(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, event TEXT, kota TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertPeserta(Peserta peserta) async {
    final db = await DbHelper2.db();
    await db.insert(
      'Peserta',
      peserta.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Peserta>> getAllPeserta() async {
    final db = await DbHelper2.db();
    final List<Map<String, dynamic>> maps = await db.query('Peserta');
    return List.generate(maps.length, (i) {
      return Peserta.fromMap(maps[i]);
    });
  }

  Future<void> deletePeserta(int id) async {
    final db = await DbHelper2.db();
    await db.delete('Peserta', where: 'id = ?', whereArgs: [id]);
  }
  

}