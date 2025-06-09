// Database/Db_helper/db_helper.dart
import 'package:ppkd_b2/tugas_13/model/model_siswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper1 {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'siswa.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE siswa(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        kelas TEXT,
        email TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertSiswa(Siswa siswa) async {
    final db = await database;
    return await db.insert('siswa', siswa.toMap());
  }

  Future<List<Siswa>> getAllSiswa() async {
    final db = await database;
    final result = await db.query('siswa');
    return result.map((e) => Siswa.fromMap(e)).toList();
  }

  Future<int> updateSiswa(Siswa siswa) async {
    final db = await database;
    return await db.update('siswa', siswa.toMap(), where: 'id = ?', whereArgs: [siswa.id]);
  }

  Future<int> deleteSiswa(int id) async {
    final db = await database;
    return await db.delete('siswa', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getTotalSiswa() async {
    final db = await database;
    final x = await db.rawQuery('SELECT COUNT(*) FROM siswa');
    return Sqflite.firstIntValue(x) ?? 0;
  }
}
