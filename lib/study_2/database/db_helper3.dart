import 'package:ppkd_b2/study_2/model/model_hewan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper3 {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'hewan.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE hewan('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'nama TEXT, '
            'jenis TEXT, '
            'umur INTEGER, '
            'berat REAL, '
            'foto TEXT)',
        );
      },
      version: 1,
    );
  }
  Future<void> insertHewan(Map<String, dynamic> data) async {
    final db = await DbHelper3.db();
    await db.insert('hewan', {
      'nama': data['nama'],
      'jenis': data['jenis'],
      'umur': data['umur'],
      'berat': data['berat'],
      'foto': data['foto'], // base64 string
    });
     print("Data tersimpan: $data"); // Tambahkan log
  }

  Future<List<ModelHewan>> getAllHewan() async {
    final db = await DbHelper3.db();
    final List<Map<String, dynamic>> maps = await db.query('hewan');
    return List.generate(maps.length, (i) {
      return ModelHewan.fromMap(maps[i]);
    });
  }
  Future<void> deleteHewan(int id) async {
    final db = await DbHelper3.db();
    await db.delete(
      'hewan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> updateHewan(int id) async {
    final db = await DbHelper3.db();
    await db.update(
      'hewan',
      {'id': id},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  

}
