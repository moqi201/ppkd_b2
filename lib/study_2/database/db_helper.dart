import 'package:ppkd_b2/study_2/model/model_hewan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hewan.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE hewan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            jenis TEXT,
            umur INTEGER,
            berat REAL,
            foto TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertHewan(ModelHewan hewan) async {
    final db = await database;
    return await db.insert('hewan', hewan.toMap());
  }

  static Future<List<ModelHewan>> getAllHewan() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('hewan');
    return List.generate(maps.length, (i) => ModelHewan.fromMap(maps[i]));
  }

  static Future<int> updateHewan(ModelHewan hewan) async {
    final db = await database;
    return await db.update(
      'hewan',
      hewan.toMap(),
      where: 'id = ?',
      whereArgs: [hewan.id],
    );
  }

  static Future<int> deleteHewan(int id) async {
    final db = await database;
    return await db.delete('hewan', where: 'id = ?', whereArgs: [id]);
  }
}
