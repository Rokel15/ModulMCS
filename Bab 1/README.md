# BAB 1 
# Widget-widget dasar pada Flutter

## Pada bab ini akan diperkenalkan cara membentuk sebuah halaman aplikasi beserta isinya dengan komponen-komponen yang tersedia dari flutter

### Material App
MaterialApp adalah Widget paling dasar dalam membentuk suatu aplikasi, untuk menggunakan MaterialApp maka perlu import 'package:flutter/material.dart';

Struktur dari Material App

    MaterialApp(
      title: ...,
      debugShowCheckedModeBanner: ...,
      theme: ...,
      home: ....
      initialRoute: ...,
      routes: {...}
      //dan lain lain
    );
### Scaffold
Scaffold adalah Widget yang umum untuk membuat halaman pada aplikasi, pada Scaffold mempunyai prpperty untuk membiat halaman seperti appBar:, body:, floatingActionButton: drawer: bottomNavigationBar: dan lain-lain

Struktur dri Scaffold :

    Scaffold(
      appBar: ...,
      body: ...,
      floatingActionButton: ...,
      drawer: ...,
      bottomNavigationBar: ...,
    )

untuk dapat menggunakan komponen-komponen pada flutter maka widget ditulis dalam class yang di**extend** dari StatelessWidget ataupun StatefulWidget. StatelessWidget dan StatfulWidget memiliki beberapa perbedaan. Beberpa perbedaan tersebut ialah
- Hanya fokus pada tampilan
- Tudak dapat menangani perubahan tampilan. Misal terdapat angka 1 pada halaman kemudian user membuat perubahan pada angka tersebut, dengan StatelessWdget hal tersebut tidak bisa dilakukan
- Dibuat dengan extends dari StatelessWidget
- Biasanya hanya digunakan untuk mengembalikan MaterialApp
- Contoh StatelessWidget :
  
