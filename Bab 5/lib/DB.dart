import 'package:sqflite/sqflite.dart';
import 'package:mcs_bab_5/catatan_model.dart';

class DB {
  static Database? catatanDb;
  static const String catatanDbTable = 'catatan';

  static Future<void> initCatatanDb() async {
    if (catatanDb != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}/catatan.db';
      catatanDb = await openDatabase(path, version: 1, onCreate: (db, version) {
        const sql = '''CREATE TABLE $catatanDbTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tanggal STRING,
          warna INTEGER,
          tugas1 STRING,
          tugas2 STRING,
          tugas3 STRING,
          entryTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
          ''';
        return db.execute(sql);
      });
    } catch (e) {
      return;
    }
  }

  //insert
  static Future<int> insert(Catatan catatan) async {
    return await catatanDb?.insert(catatanDbTable, catatan.tojson()) ?? 1;
  }

  //retrieve
  static Future<List<Map<String, dynamic>>> query() async {
    return await catatanDb!.query(catatanDbTable, orderBy: 'entryTime DESC');
  }

  //delete
  static delete(Catatan catatan) async {
    return await catatanDb!
        .delete(catatanDbTable, where: 'id=?', whereArgs: [catatan.id]);
  }

  //update warna 0
  static updateWarna0(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET warna = 0 WHERE id = ?''', [id]);
  }

  //update warna 1
  static updateWarna1(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET warna = 1 WHERE id = ?''', [id]);
  }

  //update warna 2
  static updateWarna2(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET warna = 2 WHERE id = ?''', [id]);
  }

  //update warna 3
  static updateWarna3(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET warna = 3 WHERE id = ?''', [id]);
  }

  //empty tugas 1
  static emptyTugas1(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET tugas1 = '' WHERE id = ?''', [id]);
  }

  //empty tugas 2
  static emptyTugas2(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET tugas2 = '' WHERE id = ?''', [id]);
  }

  //empty tugas 3
  static emptyTugas3(int id) async {
    return await catatanDb!.rawUpdate(
        '''UPDATE $catatanDbTable SET tugas3 = '' WHERE id = ?''', [id]);
  }
}
