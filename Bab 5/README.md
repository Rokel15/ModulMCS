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
Code pada catatan_model.dart
```dart
class Catatan {
  int? id;
  String? tanggal;
  int? warna;
  String? tugas1;
  String? tugas2;
  String? tugas3;
  String? entryTime;

  Catatan({
    this.id,
    required this.tanggal,
    required this.warna,
    required this.tugas1,
    required this.tugas2,
    required this.tugas3,
    this.entryTime,
  });

  //toJson
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tanggal'] = tanggal;
    data['warna'] = warna;
    data['tugas1'] = tugas1;
    data['tugas2'] = tugas2;
    data['tugas3'] = tugas3;
    data['entryTime'] = entryTime;
    return data;
  }

  //fromJson
  Catatan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tanggal = json['tanggal'];
    warna = json['warna'];
    tugas1 = json['tugas1'];
    tugas2 = json['tugas2'];
    tugas3 = json['tugas3'];
    entryTime = json['entryTime'];
  }
}
```
### Penjelasan
Dalam class Catatan merupakan model untuk memuat kerangka data yang akan digunakan untuk create update input delete data pada database, sehingga ketika class Catatan dipanggil maka bisa menggunakan atribut-atribut yang terdapat pada class Catatan. Di dalam class Catatan juga terdapat method tojson dan method overloading yang bernama Catatan.fromJson, method tojson digunakan ketika user melakukan 'input' data ke database dan method overloading Catatan.fromJson digunakan untuk user membaca data dari database.

---
code pada DB.dart
```dart
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
```
### Penjelasan
Di dalam file DB.dart merupakan class untuk kebutuhan database seperti inisialisasi database dan beberapa fungsi untuk melakukan beberapa aksi seperti retrieve, update dan delete.

    static Database? catatanDb;
    static const String catatatnDbTable = 'catatan';
deklarasi database dan inisialilsasi nama table database

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
jika database tidak sama dengan null(sudah terdapat database) maka tidak ada nilai kembali(nilai kembali kosong). Kemudian dalam blok try dibuat objek path untuk file database '/catatan.db' dan menginisialisasi database 'catatanDb' yang berisi openDatabase untuk membuat database dengan return db.execute(sql). catch untuk menangkap error saja.

    //insert
    static Future<int> insert(Catatan catatan) async {
      return await catatanDb?.insert(catatanDbTable, catatan.tojson()) ?? 1;
    }
pada method ini digunakan untuk input data ke database

    //retrieve
    static Future<List<Map<String, dynamic>>> query() async {
      return await catatanDb!.query(catatanDbTable, orderBy: 'entryTime DESC');
    }
pada method ini digunakan untuk membaca data di database

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
Beberapa method ini digunakan untuk mengubah nilai field warna, jadi nanti warna ditentukan/ditampilkan berdasarkan value/nilai warna yang ada pada database. Warna yang dimaksud adalah warna tema setiap record. Perhaikan gambar berikut :

![tema warna](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/tampilan%20setelah%20diisi%20data.PNG)

nanti pada ui aplikasi warna setiap record akan dibuat seperti berikut :
- apabila field warna bernilai 0 maka tema warna akan berwarna 4C4C6D (abu-abu)
- apabila field warna bernilai 1 maka tema warna akan berwarna 6F61C0 (ungu memudar)
- apabila field warna bernilai 2 maka tema warna akan berwarna biru tua [shade 900]
- apabila field warna bernilai 3 maka tema warna akan berwarna pink [shade 500]

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
Beberapa method ini digunakan untuk mengosongkan data (field tugas1, tugas2, tugas3)

---
code pada catatan_controller.dart
```dart
import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_model.dart';
import 'DB.dart';

class CatatanController extends GetxController {
  var catatanList = [].obs;

  //get all data from table
  void getCatatanData() async {
    List<Map<String, dynamic>> catatanData = await DB.query();
    catatanList.assignAll(catatanData.map((e) => Catatan.fromJson(e)).toList());
  }

  //input atau tambah data
  Future<int> addCatatan({required Catatan catatan}) async {
    return await DB.insert(catatan);
  }

  //delete
  void delete(Catatan catatan) async {
    DB.delete(catatan);
  }

  //update warna 0
  void warna0(int id) async {
    await DB.updateWarna0(id);
  }

  //update warna 1
  void warna1(int id) async {
    await DB.updateWarna1(id);
  }

  //update warna 2
  void warna2(int id) async {
    await DB.updateWarna2(id);
  }

  //update warna 3
  void warna3(int id) async {
    await DB.updateWarna3(id);
  }

  //empty Tugas 1
  void emptyTugas1(int id) async {
    await DB.emptyTugas1(id);
  }

  //empty Tugas 2
  void emptyTugas2(int id) async {
    await DB.emptyTugas2(id);
  }

  //empty Tugas 3
  void emptyTugas3(int id) async {
    await DB.emptyTugas3(id);
  }
}
```
### Penjelasan

    class CatatanController extends GetxController{...}
Pada file catatan_controller.dart membuat class 'CatatanController' untuk dijadikan controller(mengontrol database) oleh karena itu class 'CatatanController' diextends ke GetxController

    var catatanList = [].obs;

    //get all data from table
    void getCatatanData() async {
      List<Map<String, dynamic>> catatanData = await DB.query();
      catatanList.assignAll(catatanData.map((e) => Catatan.fromJson(e)).toList());
    }
membuat variabel catatanList untuk menampung list yang dapat diobservasi dengan .obs, jadi penggunaan .obs pada GetX adalah mengubah variabel biasa menjadi variabel obsevasi. Ini memungkinkan GetX untuk memantau perubahan pada variabel secara otomatis. Method getCatatanData terdapat variabel catatanData untuk membaca/retrieve database  dengan memanggil method query yang ada pada class DB dan catatanList akan disi oleh catatanData yang dimaping dengan Catatan.fromJson, karena catatanList adalah list maka konversikan ke bentuk list '.toList()'

    //input atau tambah data
    Future<int> addCatatan({required Catatan catatan}) async {
      return await DB.insert(catatan);
    }
Method addCatatan merupakan controller untuk user dapat menginput/menambah data ke database dengan return DB.insert()

    //delete
    void delete(Catatan catatan) async {
      DB.delete(catatan);
    }
Method ini digunakan untuk delete suatu record pada table database dengan return DB.delete()

    //update warna 0 - 3
    void warna0(int id) async {
      await DB.updateWarna0(id);
    }

method yang ini adalah controller yang digunakan untuk mengubah warna tema pada setiap record. dengan return mengacu ke setiap fungsi yang ada pada class DB.

    //empty Tugas 1-3
    void emptyTugas1(int id) async{
      await DB.emptyTugas1(id);
    }

Terakhir dari class CatatanController adalah controller untuk mengosongkan field tugas1, tugas2, tugas3

---
code pada main.dart
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'display_page.dart';
import 'DB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initCatatanDb();
  runApp(const CatatanApp());
}

class CatatanApp extends StatelessWidget {
  const CatatanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Catatan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: const DisplayPage(),
    );
  }
}
```
### Penjelasan
Dalam void main yang bersifat async terdapat WidgetsFlutterBinding.ensureInitialized(); yang dinisialisasi sebelum aplikasi dijalankan. Ini adalah langkah yang sangat penting dalam aplikasi karena banyak operasi yang terkait dengan UI dan rendering hanya dapat dilakukan setelah WidgetsBinding diinisialisasi. WidgetsFlutterBinding.ensureInitialized(); digunakan untuk memastikan bahwa sebelum menjalankan aplikasi Flutter, inisialisasi yang diperlukan untuk pengelolaan widget, rendering, dan fungsi-fungsi dasar lainnya telah selesai.

await DB.initCatatanDb(); bertujuan untuk memanggil menjalankan database saat aplikasi ingin dijalankan. Aplikasi akan dijalankan namun menunggu higga database selesai dibuat, jika sudah selesai maka aplikasi akan dijalankan dengan runApp(CatatanApp());

Pada aplikasi ini kita juga menggunakan package GetX sehingga agar GetX dapat digunakan maka perlu menggunakan GetMaterialApp()

---
code pada display_page.dart
```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcs_bab_5/catatan_controller.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_model.dart';
import 'add_data_page.dart';
import 'DB.dart';
import 'edit_page.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final CatatanController _catatanController = Get.put(CatatanController());

  @override
  void initState() {
    super.initState();
    _catatanController.getCatatanData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan App'),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.add_circle,
            ),
            onTap: () {
              Get.to(const AddDataPage());
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.white),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.1),
                          blurRadius: 10.0)
                    ],
                    color: const Color(0xff2E3840),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your notes in this App',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '- Write your plan',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '- Write your needs',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '- Write your memories',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 30),
                    child: Obx(() => ListView.builder(
                          itemCount: _catatanController.catatanList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            Catatan catatan =
                                _catatanController.catatanList[index];
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              padding: const EdgeInsets.all(12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: catatan.warna == 0
                                      ? const Color(0xff4C4C6D)
                                      : catatan.warna == 1
                                          ? const Color(0xff6F61C0)
                                          : catatan.warna == 2
                                              ? Colors.blue[900]
                                              : Colors.pink[500],
                                  border: Border.all(
                                      width: 3, color: Colors.white)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //display taggal, hapus tanggal, edit tanggal dan ganti warna
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${catatan.tanggal}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                setState(() {
                                                  ubahTanggal(
                                                      context,
                                                      _catatanController
                                                          .catatanList[index]);
                                                  _catatanController
                                                      .getCatatanData();
                                                });
                                              }),
                                          IconButton(
                                              icon: const Icon(Icons.brush),
                                              onPressed: () {
                                                setState(() {
                                                  if (catatan.warna == 0) {
                                                    _catatanController
                                                        .warna1(catatan.id!);
                                                  } else if (catatan.warna ==
                                                      1) {
                                                    _catatanController
                                                        .warna2(catatan.id!);
                                                  } else if (catatan.warna ==
                                                      2) {
                                                    _catatanController
                                                        .warna3(catatan.id!);
                                                  } else {
                                                    _catatanController
                                                        .warna0(catatan.id!);
                                                  }
                                                  _catatanController
                                                      .getCatatanData();
                                                });
                                              }),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                showDeleteRecordBottomSheet(
                                                    context,
                                                    _catatanController
                                                        .catatanList[index]);
                                              }),
                                          IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () {
                                                Get.to(
                                                    EditPage(catatan: catatan));
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 3,
                                    color: Colors.white,
                                  ),
                                  //tugas 1
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 1',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 1
                                      IconButton(
                                        icon: const Icon(Icons.restart_alt),
                                        onPressed: () {
                                          showEmptyTugas1BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas1}',
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //tugas 2
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 2',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 2
                                      IconButton(
                                        icon: const Icon(
                                          Icons.restart_alt,
                                        ),
                                        onPressed: () {
                                          showEmptyTugas2BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas2}',
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //tugas 3
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tugas 3',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      //hapus catetan tugas 3
                                      IconButton(
                                        icon: const Icon(Icons.restart_alt),
                                        onPressed: () {
                                          showEmptyTugas3BottomSheet(
                                              context,
                                              _catatanController
                                                  .catatanList[index]);
                                          _catatanController.getCatatanData();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${catatan.tugas3}',
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            );
                          },
                        ))),

                //untuk spasi halaman paling bawah
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> ubahTanggal(BuildContext context, Catatan catatan) async {
    DateTime? setUbahTanggal = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (setUbahTanggal != null && setUbahTanggal != DateTime.now()) {
      setState(() {
        // String formattedDate = DateFormat.yMd().format(setUbahTanggal);  bisa begini
        DB.catatanDb!.rawUpdate(
            '''UPDATE ${DB.catatanDbTable} SET tanggal = '${DateFormat.yMd().format(setUbahTanggal)}' WHERE id = ?''',
            [catatan.id]);
        _catatanController.getCatatanData();
      });
    }
  }

  showEmptyTugas1BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 1?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas1(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showEmptyTugas2BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 2?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas2(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showEmptyTugas3BottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'empty tugas 3?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.emptyTugas3(catatan.id!);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  showDeleteRecordBottomSheet(BuildContext context, Catatan catatan) {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.7,
      decoration: const BoxDecoration(
          color: Color(0xff352F44),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        children: [
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: const Text(
              'delete record?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yesOrNoButton(
                  text: 'Yes',
                  color: const Color(0xff5C5470),
                  onTap: () {
                    _catatanController.delete(catatan);
                    _catatanController.getCatatanData();
                    Get.back();
                  },
                ),
                yesOrNoButton(
                    text: 'No',
                    color: const Color(0xffB9B4C7),
                    onTap: () {
                      Get.back();
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }

  yesOrNoButton(
      {required String text, required Color color, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.8,
        height: MediaQuery.of(context).size.height / 17,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(text,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
```
### Penjelasan
    final CatatanController _catatanController = Get.put(CatetanMhsController());
penggunaan Put dari GetX untuk menginisialisasi dan mengatur instance dari CatatanController. Dengan menginisialisasi dan mengatur instance controller ini, memungkinkan komponen-komponen lain dalam aplikasi kita untuk mengakses dan berinteraksi dengan data dari database SQFLite tersebut melalui controller ini.

    @override
    void initState() {
      super.initState();
      _catatanController.getCatatanData();
    }
Di dalam initState kita memanggil _catatanController.getCatatanData(); agar langsung mendapatkan data dari database

      appBar: AppBar(
        title: const Text('Catatan App'),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.add_circle,
            ),
            onTap: (){
              Get.to(const AddDataPage());
            },
          ),
          SizedBox(width: 10,)
        ],
      ),
Pada appbar kita membuat tombol dengan Icons.add_circle untuk pindah ke halaman pengisian dan penambahan data ke database, halaman tersebut dimuat dengan class AddDataPage(), Icons.add_circledapat diperhatikan pada gambar berikut
![appBar](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/appBar.PNG)

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30),
                  child: Obx(()
                  => ListView.builder(...)
                ),
Pada Container di atas memiliki child Obx, Ini adalah widget khusus yang digunakan untuk mengamati (observe) perubahan pada variabel-variabel yang telah di-deklarasikan sebagai observables dalam controller GetX. Ketika nilai dari variabel-variabel tersebut berubah, widget Obx akan secara otomatis membangun ulang tampilan (rebuild) sesuai dengan perubahan tersebut. Pada kode di atas Obx memiliki body (maksudnya {} yang diganti dengan =>) yang bernama ListView.builder(). Ketika terjadi perubahan pada variabel yang diamati, maka Obx akan membangun kembali daftar ListView sesuai dengan perubahan tersebut.

                  => ListView.builder(
                    itemCount: _catatanController.catatanList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index){...}
Di dalam ListView.builder() terdapat beberapa property seperti kode di atas, itemCount akan menghitung untuk mengatur seberapa banyak/panjang yang akan dibangun oleh ListView.builder(). itemCount diisi _catatanController.catatanList.length yang mana catatanList adalah variabel observasi berbentuk list yang memuat database.

                    itemBuilder: (_, index) {
                    Catatan catatan =
                        _catatanController.catatanList[index];
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 15, bottom: 15),
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: catatan.warna == 0
                              ? const Color(0xff4C4C6D)
                              : catatan.warna == 1
                                  ? const Color(0xff6F61C0)
                                  : catatan.warna == 2
                                      ? Colors.blue[900]
                                      : Colors.pink[500],
                          border: Border.all(
                              width: 3, color: Colors.white)),
                        child: Column(...)
                        );
                      }
itemBuilder akan membangun Container() dan catatan merupakan objek untuk mengakses isi dari catatanList. Pada container disini akan diberi warna berdasarkan value yang ada pada record table database dan border Container berwarna putih.

apabila pada record warna bernilai 0 maka Container akan berwarna 4C4C6D

apabila pada record warna bernilai 1 maka Container akan berwarna 6F61C0

apabila pada record warna bernilai 2 maka Container akan berwarna blue[shade : 900]

apabila pada record warna bernilai selain dari 1/2/3 maka Container akan berwarna pink[shade : 500]

lihat pada contoh potongan gambar berikut

![value warna](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/field%20warna.PNG)

Selanjutnya Column yang menjadi child dari Container

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //display taggal, hapus tanggal, edit tanggal dan ganti warna
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${catatan.tanggal}',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          setState(() {
                                            ubahTanggal(context, _catatanController.catatanList[index]);
                                            _catatanController.getCatatanData();
                                          });
                                        }
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.brush),
                                        onPressed: (){
                                          setState(() {
                                            if(catatan.warna==0){
                                              _catatanController.warna1(catatan.id!);
                                            } else if(catatan.warna==1){
                                              _catatanController.warna2(catatan.id!);
                                            } else if(catatan.warna==2){
                                              _catatanController.warna3(catatan.id!);
                                            } else{
                                              _catatanController.warna0(catatan.id!);
                                            }
                                            _catatanController.getCatatanData();
                                          });
                                        }
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: (){
                                          showDeleteRecordBottomSheet(context, _catatanController.catatanList[index]);
                                        }
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: (){
                                          Get.to(EditPage(catatan: catatan));
                                        }
                                    ),
                                  ],
                                )
                              ],
                            ),
                            
                            ...
                            
                            ])
di dalam Column kitaakan membuat tampilan untuk menampilkan tanggal, icon edit untuk mengubah tanggal, icon brush untuk mengubah tema warna, icon delete untuk menghapus record, icon edit untuk mengedit record pada field tugas1, tugas2, tugas3. yang hasilnya akan seperti ini

![text pengganti](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/edit%20date%20edit%20color%20delete%20record%20edit%20record.PNG)

                            Container(
                              width: double.infinity,
                              height: 3,
                              color: Colors.white,
                            ),
                            //tugas 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 1',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 1
                                IconButton(
                                  icon: Icon(Icons.restart_alt),
                                  onPressed: (){
                                    showEmptyTugas1BottomSheet(context, _catatanController.catatanList[index]);
                                    _catatanControllerr.getCatatanData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catatan.tugas1}',
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10,),
                            //tugas 2
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 2',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 2
                                IconButton(
                                  icon: Icon(Icons.restart_alt,),
                                  onPressed: (){
                                    showEmptyTugas2BottomSheet(context, _catatanController.catatanList[index]);
                                    _catatanController.getCatatanData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catatan.tugas2}',
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10,),
                            //tugas 3
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tugas 3',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                //hapus catetan tugas 3
                                IconButton(
                                  icon: Icon(Icons.restart_alt),
                                  onPressed: (){
                                    showEmptyTugas3BottomSheet(context, _catatanController.catatanList[index]);
                                    _catatanController.getCatatanData();
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '${catatan.tugas3}',
                              textAlign: TextAlign.justify,
                            ),
Dalam 1 record terdapat 3 field yang diisi(tugas1, tugas2, tugas3), pada code di atas terdapat masing-masing icon restart alt untuk mengosongkan isi dari tugas1, tugas2, tugas3 dengan memanggil showEmptyTugas1BottomSheet(), showEmptyTugas2BottomSheet(), showEmptyTugas3BottomSheet yang memunculkan bottom sheet dan memberi pertanyaan apakah isi tersebut ingin dikosongkan atau tidak seperti pada contoh dibawah

![bottom sheet](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/bottom%20sheet%20for%20tugas.PNG)

Jadi untuk mengosongkan record pada filed tugas1, tugas2, tugas3 dengan memanggil showEmptyTugas1BottomSheet, showEmptyTugas2BottomSheet, showEmptyTugas3BottomSheet kemudian user diberi pertanyaan apakah ingin dikosongkan atau tidak. Jika user memilih 'Yes' maka akan dihapus, jika memilih 'No' maka kembali ke halaman awal

Isi dari method showEmptyTugas1BottomSheet, showEmptyTugas2BottomSheet, showEmptyTugas3BottomSheet

    //...
    showEmptyTugas1BottomSheet(BuildContext context, Catatan catatan) {
      Get.bottomSheet(Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5.7,
        decoration: const BoxDecoration(
            color: Color(0xff352F44),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          children: [
            Container(
              height: 7,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: const Text(
                'empty tugas 1?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  yesOrNoButton(
                    text: 'Yes',
                    color: const Color(0xff5C5470),
                    onTap: () {
                      _catatanController.emptyTugas1(catatan.id!);
                      _catatanController.getCatatanData();
                      Get.back();
                    },
                  ),
                  yesOrNoButton(
                      text: 'No',
                      color: const Color(0xffB9B4C7),
                      onTap: () {
                        Get.back();
                      })
                ],
              ),
            )
          ],
        ),
      ));
    }

  //...
Saat salah satu method ini dipanggil maka aplikasi akan memunculkan bottom sheet untuk bertanya kepada usetr apakah benar data ingin dihapus atau tidak.

Tidak hanya pengosongan record pada field tugas1, tugas2, tugas3 saja namun untuk menghapus 1 record(semua data dalam 1 baris) juga menggunakan bottom sheet untuk bertanya kepada user apakah data ingin dihapus atau tidak, lihat gambar berikut

![delete record](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/bottom%20sheet%20delete%20record.PNG)

Menghapus record dapat memanggil method showDeleteRecordBottomSheet(). isi dari showDeleteRecordBottomSheet()

    //...

    showDeleteRecordBottomSheet(BuildContext context, Catatan catatan) {
      Get.bottomSheet(Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5.7,
        decoration: const BoxDecoration(
            color: Color(0xff352F44),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          children: [
            Container(
              height: 7,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: const Text(
                'delete record?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  yesOrNoButton(
                    text: 'Yes',
                    color: const Color(0xff5C5470),
                    onTap: () {
                      _catatanController.delete(catatan);
                      _catatanController.getCatatanData();
                      Get.back();
                    },
                  ),
                  yesOrNoButton(
                      text: 'No',
                      color: const Color(0xffB9B4C7),
                      onTap: () {
                        Get.back();
                      })
                ],
              ),
            )
          ],
        ),
      ));
    }

    //...

Di dalam bottom sheet terdapat button yang bertuliskan 'Yes' dan 'No', button akan kita buat widget terpisah di luar method yang digunakan untuk menampilkan bottom sheet seperti berikut

     yesOrNoButton(
        {required String text, required Color color, required Function() onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.8,
          height: MediaQuery.of(context).size.height / 17,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Center(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
        ),
      );
    }

Tadi kita membuat fitur untuk mengubah tanggal, saat mengubah tanggal kita memanggil ubahTanggal() sehingga kita harus membuat method ubahTanggal(). Isi dari method ubahTanggal() adalah seperti berikut
  
  Future<void> ubahTanggal(BuildContext context, Catatan catatan) async {
    DateTime? setUbahTanggal = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));

    if (setUbahTanggal != null && setUbahTanggal != DateTime.now()) {
      setState(() {
        // String formattedDate = DateFormat.yMd().format(setUbahTanggal);  bisa begini
        DB.catatanDb!.rawUpdate(
            '''UPDATE ${DB.catatanDbTable} SET tanggal = '${DateFormat.yMd().format(setUbahTanggal)}' WHERE id = ?''',
            [catatan.id]);
        _catatanController.getCatatanData();
      });
    }
  }

      //...
Saat mengubah tanggal kita tidak menggunakan controller namun langsung menggunakan query DML dari sql untuk update tanggal seperti pada code di atas menggunakan  perintah

    '''UPDATE ${DB.catatanDbTable} SET tanggal = '${DateFormat.yMd().format(setUbahTanggal)}' WHERE id = ?''',
            [catatan.id]);

---
code pada add_data_page.dart
```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'catatan_controller.dart';
import 'catatan_model.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final CatatanController _catatanController = Get.put(CatatanController());

  String pilihTanggal = 'Select Date';

  Future selectDate(BuildContext context) async {
    final DateTime? setDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (setDate != null && setDate != DateTime.now()) {
      setState(() {
        pilihTanggal = DateFormat.yMd().format(setDate).toString();
      });
    }
  }

  int pilihWarna = 1;

  TextEditingController tugas1 = TextEditingController();
  TextEditingController tugas2 = TextEditingController();
  TextEditingController tugas3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.1),
                      blurRadius: 10.0)
                ],
                color: const Color(0xff2E3840),
              ),
              child: const Padding(
                  padding: EdgeInsets.all(13),
                  child: Text('Add your note',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600))),
            ),

            //pilih tanggal
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pilihTanggal,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    child: const Icon(Icons.edit_calendar),
                    onTap: () {
                      selectDate(context);
                    },
                  )
                ],
              ),
            ),

            //pilih warna
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  children: List<Widget>.generate(4, (index) {
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(left: 13, right: 8),
                        height: MediaQuery.of(context).size.width / 13,
                        width: MediaQuery.of(context).size.width / 13,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: index == 0
                                ? const Color(0xff4C4C6D)
                                : index == 1
                                    ? const Color(0xff6F61C0)
                                    : index == 2
                                        ? Colors.blue[900]
                                        : Colors.pink[500]),
                        child: pilihWarna == index
                            ? const Icon(Icons.done_all)
                            : Container(),
                      ),
                      onTap: () {
                        setState(() {
                          pilihWarna = index;
                        });
                      },
                    );
                  }),
                ),
              ],
            ),

            //isi tugas 1
            Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tugas 1',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas1,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purpleAccent))),
                  )
                ],
              ),
            ),

            //isi tugas 2
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tugas 2',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas2,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purpleAccent))),
                  )
                ],
              ),
            ),

            //isi tugas 3
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tugas 3',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas3,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purpleAccent))),
                  )
                ],
              ),
            ),

            //save button
            Container(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(Icons.save_outlined),
                      onPressed: () {
                        addToCatatan();
                        Get.back();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addToCatatan() async {
    await _catatanController.addCatatan(
      catatan: Catatan(
        tanggal: pilihTanggal,
        warna: pilihWarna,
        tugas1: tugas1.text,
        tugas2: tugas2.text,
        tugas3: tugas3.text,
      ),
    );
    _catatanController.getCatatanData();
  }
}
```
### Penjelasan
Pertama kita membuat method untuk mengatur tanggal
    
    String pilihTanggal = 'Select Date';
  
    Future selectDate(BuildContext context) async{
      final DateTime? setDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2100),
      );
      if(setDate != null && setDate != DateTime.now()){
        setState(() {
          this.pilihTanggal = DateFormat.yMd().format(setDate).toString();
        });
      }
    }
Apabila selectDate() dipanggil maka user dapat mengatur tanggal dan variabel akan berubah sesuai tanggal yang ditentukan oleh user. 

    TextEditingController tugas1 = TextEditingController();
    TextEditingController tugas2 = TextEditingController();
    TextEditingController tugas3 = TextEditingController();
Sedangkan variabel tugas1, tugas2, tugas3 merupakan controller yang digunakan untuk menyimpan isi dari textfield. Untuk membentuk halaman yang digunakan untuk mengisi/menambah data ke database masih sama menggunakan Scaffold() dan body pada Scaffold diisi dengan ListView() yang dikasih padding pada bagian atas kiri dan kanan

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: ListView(...)
        )
children pada ListView() terdapat Container sebagai heading/pembuka pada halaman
        
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.1),
                      blurRadius: 10.0
                  )
                ],
                color: Color(0xff2E3840),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Text('Add your note', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
            ),
          
          //...
          ]  
        )
boxShadow digunakan untuk membuat bayangan berwarna pada garis tepi

        child: ListView(
          children: [
          //...

          //pilih tanggal
          Container(
            padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$pilihTanggal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  GestureDetector(
                    child: Icon(Icons.edit_calendar),
                    onTap: (){
                      selectDate(context);
                    },
                  )
                ],
            ),
          ),

          //...
          ]  
        )
widget selanjutnya pada kode di atas digunakan untuk user dapat memilih tanggal, hasil dari widget yang dibuat seperti di atas akan menjadi seperti berikut

![select date](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/user%20can%20select%20date.PNG)

Widget selanjutnya untuk pemilihan warna

        child: ListView(
          children: [
          //...

          //pilih warna
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Wrap(
                  children: List<Widget>.generate(
                      4, (index) {
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 13, right: 8),
                            height: MediaQuery.of(context).size.width / 13,
                            width: MediaQuery.of(context).size.width / 13,
                            decoration: BoxDecoration(
                              borderRadius : BorderRadius.circular(15),
                              color:
                              index==0? Color(0xff4C4C6D) :
                              index==1? Color(0xff6F61C0) :
                              index==2? Colors.blue[900] :
                              Colors.pink[500]
                            ),
                            child:
                            pilihWarna==index?
                            Icon(Icons.done_all) : Container(),
                          ),
                          onTap: (){
                            setState(() {
                              pilihWarna = index;
                            });
                          },
                        );
                  }),
                ),
              ),
            ],
          ),

          //...
          ]  
        )
pilihWarna adalah variabel yang sudah dideklarasi di awal, yang digunakan untuk menampung value dari index. kita membuat di dalam wrap me-generate 4 Container() yang dibungkus dengan GestureDetector(). Tiap Container memiliki warna yang berbeda-beda berdasarkan index, Container memiliki child icon done_all sesuai value yang ada pada variabel pilihWarna, dan dengan onTap akan menentukan value dari variabel pilihWarna. Jadi apabila user me-klik salah satu yang ada pada 4 Container tersebut maka Container yang diklik akan memiliki icon done_all(tanda check), hasil dari widget yang dibuat akan menghasilkan tampilan sebagai berikut

![select color](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%206/select%20color.PNG)

Karena dari awal deklarasi variabel pilihWarna adalah 1 maka Container pada index ke 1 yang memiliki icon done_all(tanda check)

Selanjutnya membentuk widget untuk user mengisi field tugas1, tugas2, tugas3

        child: ListView(
          children: [
          //...

          //isi tugas 1
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tugas 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                TextFormField(
                  controller: tugas1,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purpleAccent)
                    )
                  ),
                )
              ],
            ),
          ),
          tugas 2,
          tugas 3,
          //...
          ]  
        )


dan terakhir adalah membuat button untuk menyimpan data ke database

        child: ListView(
          children: [
          //...

          //save button
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(Icons.save_outlined),
                    onPressed: (){
                      addToCatatan();
                      Get.back();
                    }
                )
              ],
            ),
          )
          
          //...
          ]  
        )
pada onPressed memanggil addToCatatan() untuk menyimpan data ke database, sehingga kita juga harus membuat addToCatatan()

    //...
    
    @override
    Widget build(BuildContext context) {
  
    //...
    
    }
  
    addToCatatan() async {
      await _catatanController.addCatatan(
        catatan: Catatan(
          tanggal: pilihTanggal,
          warna: pilihWarna,
          tugas1: tugas1.text,
          tugas2: tugas2.text,
          tugas3: tugas3.text,
        ),
      );
        _catatanController.getCatatanData();
    }

Kita juga harus memanggil _catatanController.getCatatanData() agar data yang ada di database langsung terbaca dan dapat ditampilkan

---
code pada edit_page.dart
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcs_bab_5/catatan_controller.dart';
import 'DB.dart';
import 'catatan_model.dart';

class EditPage extends StatefulWidget {
  final Catatan? catatan;

  const EditPage({super.key, required this.catatan});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController tugas1 = TextEditingController();
  TextEditingController tugas2 = TextEditingController();
  TextEditingController tugas3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    tugas1.text = widget.catatan?.tugas1 ?? '';
    tugas2.text = widget.catatan?.tugas2 ?? '';
    tugas3.text = widget.catatan?.tugas3 ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final CatatanController catatanController = Get.put(CatatanController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.1),
                        blurRadius: 10.0)
                  ],
                  color: const Color(0xff2E3840),
                ),
                child: const Padding(
                    padding: EdgeInsets.all(13),
                    child: Text('Edit your note',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
              ),
              // Tugas 1
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 1',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas1,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 2
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 2',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas2,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 3
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tugas 3',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: tugas3,
                      maxLines: null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      //save
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
        ),
        onPressed: () async {
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas1 = '${tugas1.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas2 = '${tugas2.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas3 = '${tugas3.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          catatanController.getCatatanData();
          Get.back();
        },
      ),
    );
  }
}
```
### Penjelasan
di dalam file edit_page.dart kita membuat sebuah class bernama EditPage, class ini dibuat untuk memuat halaman perubahan record pada field tugas1, tugas2, tugas3. class EditPage dipanggil ketika user menekan button edit yang tadi kita buat pada file display_page.dart

    IconButton(
        icon: Icon(Icons.edit),
        onPressed: (){
          Get.to(EditPage(catatan: catatan));
        }
    ),
class EditPage mempunyai constructor agar ketika class EditPage dipanggil dapat mengirim data ke class EditPage.

    TextEditingController tugas1 = TextEditingController();
    TextEditingController tugas2 = TextEditingController();
    TextEditingController tugas3 = TextEditingController();
  
    @override
    void initState() {
      super.initState();
      tugas1.text = widget.catetanMhsModel?.tugas1 ?? '';
      tugas2.text = widget.catetanMhsModel?.tugas2 ?? '';
      tugas3.text = widget.catetanMhsModel?.tugas3 ?? '';

initState disini berfungsi agar controller untuk TextFormField memiliki isi data sebelumnya,

         ListView(
           children: [
              //...
             
              // Tugas 1
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    TextFormField(
                      controller: tugas1,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 2
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    TextFormField(
                      controller: tugas2,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
              //Tugas 3
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tugas 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    TextFormField(
                      controller: tugas3,
                      maxLines: null,
                    ),
                  ],
                ),
              )
            ]
        )
User bebas dapat mengubah apapun isi dari textformfield, dan yang terakhir kita membuat button save untuk menyimpan perubahan yang baru pada tugas1, tugas2, tugas3 menggunakan floatingActionButton

      appBar : //...
      body : //...
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
        ),
        onPressed: () async {
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas1 = '${tugas1.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas2 = '${tugas2.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas3 = '${tugas3.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          catatanController.getCatatanData();
          Get.back();
        },
      ),

perubahan data yang dilakukan user pada textformfield akan disimpan oleh controller masing-masing textformfield lalu dengan floatingActionButton user menyimpan perubahan tersebut ke database dengan menggunakan query update SQL
          
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas1 = '${tugas1.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas2 = '${tugas2.text}' WHERE id = ?''',
              [widget.catatan?.id]);
          await DB.catatanDb!.rawUpdate(
              '''UPDATE ${DB.catatanDbTable} SET tugas3 = '${tugas3.text}' WHERE id = ?''',
              [widget.catatan?.id]);
catatanController.getCatatanData(); agar data dapat dibaca langsung membaca dan Get.back(); untuk kembali ke halaman awal.

---
## Laporan Pendahuluan(LP)
1. Jelaskan apa itu Database SQL!

2. Jelaskan apa itu DDL dan DML!
   
3. Jelaskan apa itu SQFLite!
 
4. Apa peran database dan bagaimana jika suatu sistem informasi tidak memiliki database?

## Laporan Akhir(LA)
1. Berikan kesimpulan singkat pada Bab 5!
