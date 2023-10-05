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
s
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
