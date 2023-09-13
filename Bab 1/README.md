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
Tampilan aplikasi yang akan dibangun

![Tampilan Home](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/tampilan%20bab%201.PNG)
![message Receiver](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/message%20receiver.PNG)

Dari tampilan di atas terdapat button '<' dan '>' untuk menambah angka dan mengurangi angka. Di bawahnya merupakan kalkulator penjumlahan sederhana, tampilan result adalah hasil dari penjumlahan dan icon restart untuk reset hasil penjumlahan. Di bawahnya lagi terdapat textfield, apabila user mengisi textfield tersebut lalu klik icon send maka halaman akan berpindah dan data yang diisi akan dikirim ke halaman berikutnya untuk ditampilkan. Terakhir yang paling bawah adalah 
button untuk menuju link [Google](https://flutter.dev)

Buatlah project baru dan beri nama praktikum_mcs_bab1(untuk nama bebas) dan pilihlah folder untuk tempat menyimpan project. Buka main.dart untuk memulai penulisan code. perhatikan struktur folder project seperti di bawah ini dan lihat main.dart berada

![Struktur Folder](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%201/Struktur%20Folder.PNG)

code bawaan dari flutter pada main.dart bisa dihapus atau bisa juga tidak pada bagian-bagian tertentu seperti

    import 'package:flutter/material.dart';
dan

    void main() {
      runApp(const MyApp());
    }

dari kode diatas bisa dianjut untuk melanjutkan praktikum dan buatlah kelas MyApp dengan extends StatelessWidget, runApp pada fungsi main menjalankan class MyApp dan pada MyApp terdapat method Widget build dengan return MaterialApp
    
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
    
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Bab 1',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green
          ),
          home: HomePage()
        );
      }
    }


title adalah label atau deskripsi aplikasi, debugShowCheckedModeBanner dikondisikan false agar menghilangkan banner yang terletak di kana atas, theme untuk mengatur tema warna tampilan dan home adalah properti yang digunakan untuk mengatur hal apa yang dijalankan pertama. home bisa diisi dengan suatu class ataupun langsung memanggil Scaffold. Di sini home berisi HomePage artinya class HomePage akan dijalankan terlebih dahulu sebelum class yang lain.

Buatalah HomePage.dart berisi class HomePage

    class HomePage extends StatefulWidget {
        const HomePage({Key? key}) : super(key: key);
    
        @override
        State<HomePage> createState() => _HomePageState();
    }
    
    class _HomePageState extends State<HomePage> {
        //...
    }
