# BAB 5
# Sqflite
### Pada bab ini kita akan mempelajari database lokal pada suatu aplikasi yang dibangun dengan menggunakan flutter, database lokal yang kita akan gunakan adalah sqlite dengan package sqflite. Kita akan membangun aplikasi 'catatan' sederhana dengan konsep mirip seperti note pada smartphone umumnya dan datanya disimpan di database.

## Praktikum Bab 5
Tampilan aplikasi yang akan dibangun

Tampilan awal halaman aplikasi sebelum ada data yang dimasukkan
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20awal.PNG" alt="Teks Pengganti">
</div>

---
Halaman pengisian data, apabila user menekan button add sebelah kanan atas appbar pada halaman awal maka user akan berpindah ke halaman ini

![Gambar 1](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20pengisian1.PNG) ![Gambar 2](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20pengisian2.PNG)

---
Lalu ini adalah halaman jika user sudah memasukkan beberapa catatan
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20setelah%20diisi%20data.PNG" alt="tampilan setelah diisi data.PNG">
</div>

---
Terakhir ini adalah halaman untuk user melakukan edit pada catatan
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20editing%20data.PNG" alt="Teks Pengganti">
</div>

---
Pertama-tama tambahkanlah terlebih dahulu packages yang akan kita gunakan

![Packages](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/packages.PNG)

Perhatikan file-file berikut.

![Packages](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/file-file%20berisi%20kode.PNG)

Buatlah file-file seperti di atas pada project yang dibuat pada praktikum kali ini

---
Code pada CatetanMhsModel.dart

    class CatetanMhsModel {
      int? id;
      String? tanggal;
      int? warna;
      String? tugas1;
      String? tugas2;
      String? tugas3;
      String? entryTime;
    
      CatetanMhsModel({
        this.id,
        required this.tanggal,
        required this.warna,
        required this.tugas1,
        required this.tugas2,
        required this.tugas3,
        this.entryTime,
      });
    
      //toJson
      Map<String, dynamic> tojson(){
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['tanggal'] = this.tanggal;
        data['warna'] = this.warna;
        data['tugas1'] = this.tugas1;
        data['tugas2'] = this.tugas2;
        data['tugas3'] = this.tugas3;
        data['entryTime'] = this.entryTime;
        return data;
      }
    
      //fromJson
      CatetanMhsModel.fromJson(Map<String, dynamic> json){
        id = json['id'];
        tanggal = json['tanggal'];
        warna = json['warna'];
        tugas1 = json['tugas1'];
        tugas2 = json['tugas2'];
        tugas3 = json['tugas3'];
        entryTime = json['entryTime'];
      }
    }

### Penjelasan
Dalam class CatetanMhsModel merupakan model untuk memuat kerangka data yang akan digunakan untuk create update input delete data pada database, sehingga ketika class CatetanMhsModel dipanggil maka bisa menggunakan atribut-atribut yang terdapat pada class CatetanMhsModel. Di dalam class CatetanMhsModel juga terdapat method tojson dan method overloading yang bernama CatetanMhsModel.fromJson, method tojson digunakan ketika user melakukan 'input' data ke database dan method overloading CatetanMhsModel.fromJson digunakan untuk user membaca data dari database.

---
code pada DB.dart

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
### Penjelasan
Di dalam file DB.dart merupakan class untuk kebutuhan database seperti inisialisasi database dan bebera fungsi untuk melakukan beberapa aksi seperti retrieve, update dan delete.

    static Database? catetanMhsDB;
    static final String catetanMhsDbTable = 'catetanMhs';
deklarasi database dan inisialilsasi nama table database

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
jika database tidak sama dengan null(sudah terdapat database) maka tidak ada nilai kembali(nilai kembali kosong). Kemudian dalam blok try dibuat objek path untuk file database '/catetanMhs.db' dan menginisialisasi database 'catetanMhsDB' yang berisi openDatabase untuk membuat database dengan return db.execute(sql). catch untuk menangkap error saja.

    //insert
    static Future<int> insert(CatetanMhsModel catetanMhsModel) async{
      return await catetanMhsDB?.insert(catetanMhsDbTable, catetanMhsModel.tojson())??1;
    }
pada method ini digunakan untuk input data ke database

    //retrieve
    static Future<List<Map<String, dynamic>>> query() async{
      return await catetanMhsDB!.query(
        catetanMhsDbTable,
        orderBy: 'entryTime DESC'
      );
    }
pada method ini digunakan untuk membaca data di database

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
Beberapa method ini digunakan untuk mengubah nilai field warna, jadi nanti warna ditentukan/ditampilkan berdasarkan value/nilai warna yang ada pada database. Warna yang dimaksud adalah warna tema setiap record. Perhaikan gambar berikut :

![tema warna](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20setelah%20diisi%20data.PNG)

nanti pada ui aplikasi warna setiap record akan dibuat seperti berikut :
- apabila field warna bernilai 0 maka tema warna akan berwarna 4C4C6D (abu-abu)
- apabila field warna bernilai 1 maka tema warna akan berwarna 6F61C0 (ungu memudar)
- apabila field warna bernilai 2 maka tema warna akan berwarna biru tua [shade 900]
- apabila field warna bernilai 3 maka tema warna akan berwarna pink [shade 500]

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
Beberapa method ini digunakan untuk mengosongkan data (field tugas1, tugas2, tugas3)

---
code pada CatetanMhsController.dart

    import 'package:get/get.dart';
    import 'package:mcs_bab_5/CatetanMhsModel.dart';
    import 'DB.dart';
    
    class CatetanMhsController extends GetxController{
    
      @override
      void onReady() {
        super.onReady();
      }
    
      var CatetanMhsList = [].obs;
    
      //get all data from table
      void getCatetanMhsData() async{
        List<Map<String, dynamic>> CatetanMhsData = await DB.query();
        CatetanMhsList.assignAll(CatetanMhsData.map((e) => new CatetanMhsModel.fromJson(e)).toList());
      }
    
      //input atau tambah data
      Future<int> addCatetanMhs({required CatetanMhsModel catetanMhsModel}) async{
        return await DB.insert(catetanMhsModel!);
      }
    
      //delete
      void delete(CatetanMhsModel catetanMhsModel) async{
        DB.delete(catetanMhsModel);
      }
    
      //update warna 0
      void warna0(int id) async{
        await DB.updateWarna0(id);
      }
    
      //update warna 1
      void warna1(int id) async{
        await DB.updateWarna1(id);
      }
    
      //update warna 2
      void warna2(int id) async{
        await DB.updateWarna2(id);
      }
    
      //update warna 3
      void warna3(int id) async{
        await DB.updateWarna3(id);
      }
    
      //empty Tugas 1
      void emptyTugas1(int id) async{
        await DB.emptyTugas1(id);
      }
    
      //empty Tugas 2
      void emptyTugas2(int id) async{
        await DB.emptyTugas2(id);
      }
    
      //empty Tugas 3
      void emptyTugas3(int id) async{
        await DB.emptyTugas3(id);
      }
    }
### Penjelasan

    class CatetanMhsController extends GetxController{...}
Pada file CatetanMhsController.dart membuat class 'CatetanMhsController' untuk dijadikan controller(mengontrol database) oleh karena itu class 'CatetanMhsController' diextends ke GetxController

    var CatetanMhsList = [].obs;
  
    //get all data from table
    void getCatetanMhsData() async{
      List<Map<String, dynamic>> CatetanMhsData = await DB.query();
      CatetanMhsList.assignAll(CatetanMhsData.map((e) => new CatetanMhsModel.fromJson(e)).toList());
    }
membuat variabel CatetanMhsList untuk menampung list yang dapat diobservasi dengan .obs, jadi penggunaan .obs pada GetX adalah mengubah variabel biasa menjadi variabel obsevasi. Ini memungkinkan GetX untuk memantau perubahan pada variabel secara otomatis. Method getCatetanMhsData terdapat variabel CatetanMhsData untuk membaca/retrieve database  dengan memanggil method query yang ada pada class DB dan CatetanMhsList akan disi oleh CatetanMhsData yang dimaping dengan CatetanMhsModel.fromJson, karena CatetanMhsList adalah list maka konversikan ke bentuk list '.toList()'

    //input atau tambah data
    Future<int> addCatetanMhs({required CatetanMhsModel catetanMhsModel}) async{
      return await DB.insert(catetanMhsModel!);
    }
Method addCatetanMhs merupakan controller untuk user dapat menginput/menambah data ke database dengan return DB.insert()

    //delete
    void delete(CatetanMhsModel catetanMhsModel) async{
      DB.delete(catetanMhsModel);
    }
Method ini digunakan untuk delete suatu record pada table database dengan return DB.delete()

    //update warna 0
    void warna0(int id) async{
      await DB.updateWarna0(id);
    }
  
    //update warna 1
    void warna1(int id) async{
      await DB.updateWarna1(id);
    }
  
    //update warna 2
    void warna2(int id) async{
      await DB.updateWarna2(id);
    }
  
    //update warna 3
    void warna3(int id) async{
      await DB.updateWarna3(id);
    }
method yang ini adalah controller yang digunakan untuk mengubah warna tema pada setiap record. dengan return mengacu ke setiap fungsi yang ada pada class DB.

    //empty Tugas 1
    void emptyTugas1(int id) async{
      await DB.emptyTugas1(id);
    }
  
    //empty Tugas 2
    void emptyTugas2(int id) async{
      await DB.emptyTugas2(id);
    }
  
    //empty Tugas 3
    void emptyTugas3(int id) async{
      await DB.emptyTugas3(id);
    }
Terakhir dari class CatetanMhsController adalah controller untuk mengosongkan field tugas1, tugas2, tugas3

---
xx
