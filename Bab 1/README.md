# BAB 1 
# Widget-widget dasar pada Flutter

### Pada bab ini akan diperkenalkan cara membentuk sebuah halaman aplikasi beserta isinya dengan komponen-komponen yang tersedia dari flutter

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

StatelessWidget
- Hanya fokus pada tampilan
- Tidak dapat menangani perubahan tampilan. Misal terdapat angka 1 pada halaman kemudian ingin dilakukakn perubahan tertentu dengan aktivitas tertentu pada angka tersebut, dengan StatelessWdget hal tersebut tidak bisa dilakukan
- Dibuat dengan extends dari StatelessWidget
- Biasanya hanya digunakan untuk mengembalikan MaterialApp
- Contoh StatelessWidget :
  
        class MyApp extends StatelessWidget {
          const MyApp({super.key});
          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              title: ...,
              theme: ...,
              home: ...,
            );
          }
        }

StatefulWidget
- Dapat menangani perubahan tampilan,  Misal terdapat angka 1 pada halaman kemudian ingin dilakukakn perubahan tertentu dengan aktivitas tertentu pada angka tersebut, dengan StatefulWdget hal tersebut bisa dilakukan
- Dibuat dengan extends dari StatefulWidget
- Menggunakan 2 class(widget dan state)
- Contoh StatefulWidget :

        class MyHomePage extends StatefulWidget {
          
            @override
            State<MyHomePage> createState() => _MyHomePageState();
        }
        
        class _MyHomePageState extends State<MyHomePage> {
            @override
            ...
        }

## Praktikum Bab 1
Buatlah project baru dan beri nama praktikum_mcs_bab1(untuk nama bebas) dan pilihlah folder untuk tempat menyimpan project. Buka main.dart untuk memulai penulisan code. perhatikan struktur folder project seperti di bawah ini dan lihat main.dart berada

![Struktur Folder](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/Struktur%20Folder.PNG)
