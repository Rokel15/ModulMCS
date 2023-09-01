import 'package:sqflite/sqflite.dart';
import 'package:mcs_bab_5/CatetanMhsModel.dart';

class DB{
  static Database? catetanMhsDB;
  static final String catetanMhsDbTable = 'catetanMhs';

  static Future<void> initcatetanMhsDb() async{
    if(catetanMhsDB!=null){
      return;
    } try{
      String path = await getDatabasesPath() + '/catetanMhs.db';
      catetanMhsDB = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version){
          final sql =
          '''CREATE TABLE $catetanMhsDbTable(
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
        }
      );
    } catch(e){
      return;
    }
  }

  //insert
  static Future<int> insert(CatetanMhsModel catetanMhsModel) async{
    return await catetanMhsDB?.insert(catetanMhsDbTable, catetanMhsModel.tojson())??1;
  }

  //retrieve
  static Future<List<Map<String, dynamic>>> query() async{
    return await catetanMhsDB!.query(
      catetanMhsDbTable,
      orderBy: 'entryTime DESC'
    );
  }

  //delete
  static delete(CatetanMhsModel catetanMhsModel) async{
    return await catetanMhsDB!.delete(
        catetanMhsDbTable,
        where: 'id=?',
        whereArgs: [catetanMhsModel.id]
    );
  }

  //update warna 0
  static updateWarna0(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET warna = 0 WHERE id = ?''', [id]);
  }

  //update warna 1
  static updateWarna1(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET warna = 1 WHERE id = ?''', [id]);
  }

  //update warna 2
  static updateWarna2(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET warna = 2 WHERE id = ?''', [id]);
  }

  //update warna 3
  static updateWarna3(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET warna = 3 WHERE id = ?''', [id]);
  }

  //empty tugas 1
  static emptyTugas1(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET tugas1 = '' WHERE id = ?''', [id]);
  }

  //empty tugas 2
  static emptyTugas2(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET tugas2 = '' WHERE id = ?''', [id]);
  }

  //empty tugas 3
  static emptyTugas3(int id) async{
    return await catetanMhsDB!.rawUpdate('''UPDATE $catetanMhsDbTable SET tugas3 = '' WHERE id = ?''', [id]);
  }
}