# BAB 2
# Dinamis UI
### Pada bab ini akan diperkenalkan cara membuat ui secara dinamis menggunakan ListView.builder(), sebelumnya pada bab 1 kita sudah menggunakan ListView untuk menampung beberapa widget, dengan ListView.builder akan *generate* komponen-komponen yang diatur sedemikian rupa sebanyak data yang tersedia. Data yang tersedia bisa diambil dari database ataupun data dummy. Namun pada bab 2 ini kita akan membuat dinamis ui yang mana datanya berasal dari data dummy.

## Praktikum Bab 2
Tampilan aplikasi yang akan dibangun

Tampilan Awal dengan ListView.builder
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%202/tampilan%20awal%20dengan%20ListView.Builder.png" alt="Teks Pengganti">
</div>

---
Tampilan halaman data detail
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%202/halaman%20salah%20satu%20data%20detail.PNG" alt="Teks Pengganti">
</div>

Pada bab 2 ini kita akan membuat beberapa file .dart untuk membuat aplikasi. Pembuatan aplikasi dalam beberapa kasus file-file yang digunakan sering dikelompokkan pada folder-folder tertentu. Namun tidak setiap orang ketika membangun project memiliki struktur folder-folder yang sama, artinya pembuatan file-file dan folder-folder terpisah bersifat opsional. Perhatikan struktur folder-folder dan file-file untuk bab 2 kali ini sebagai berikut
Tampilan halaman data detail
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%202/struktur%20folder%20dan%20file.PNG" alt="Teks Pengganti">
</div>

Sebelumnya kita tambahkan dependencies pada pubspec.yaml, buka link [https://pub.dev/](https://pub.dev/) cari get 4.6.6(versi bisa berubah) dan google_fonts: ^5.1.0(versi bisa berubah). Salin dan paste ke file pubspec.yaml pada bagian dependencies, lihat gambar di bawah

<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%202/dependencies.PNG" alt="Teks Pengganti">
</div>

---
code pada main.dart

    import 'package:get/get.dart';
    
    void main() {
      runApp(const CatBreedApp());
    }
    
    class CatBreedApp extends StatelessWidget {
      const CatBreedApp({Key? key}) : super(key: key);
    
      @override
      Widget build(BuildContext context) {
        return GetMaterialApp(
          title: 'Cat Breed',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: const ColorScheme.dark()),
          home: const HomePage(),
        );
      }
    }
Fungsi main menjalankan CatBreedApp() yang mana CatBreedApp() memiliki nilai balik return GetMaterialApp(). Apabila ingin menggunakan GetX(dependencies) maka yang digunakan bukanlah MaterialApp() melainkan GetMaterialApp(). GetMaterialApp() masih memiliki fungsi yang sama dengan MaterialApp() namun dengan GetMaterialApp() kita bisa menggnukanakan semua yang ada pada dependencies GetX. Singkatnya tujuan dari GetX ini adalah memudahkan pengembang ataupun pengguna aplikasi, GetX mempunyai 3 prinsip
- Productivity
- Performance
- Organization

Pada Bab 2 ini kita menggunakan GetX untuk perpindahan halaman, perpindahan halaman pada Bab 1 menggunakan Navigator.push(context, MaterialPageRoute()); maka dengan GetX cukup tulis Get.to()

---
code pada cat.dart
  
    class Cat {
      String urlImage;
      String name;
      String desc;
    
      Cat({
        required this.urlImage,
        required this.name,
        required this.desc,
      });
    }


class Cat adalah modeling untuk memuat atribut-atribut kebutuhan pada tampilan, ketika class Cat dipanggil maka akan diminta mengisi sesuai yang ada pada constructor. Pada Dalam kasus ini model yang dibuat adalah urlImage, name, desc.

---
code pada cats_data.dart

    List<Cat> cats = [
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/persia.jpg",
          name: "Persia",
          desc:
              '''Persia merupakan jenis kucing dengan bulu panjang yang lebat dan wajah bulat yang menggemaskan. Mereka dikenal dengan sifat yang tenang, penyayang, dan cocok sebagai kucing peliharaan dalam ruangan.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/ragdoll.png",
          name: "Ragdoll",
          desc:
              '''Ragdoll merupakan kucing besar dengan bulu panjang yang halus dan mata biru memikat. Mereka terkenal dengan kecenderungan mereka untuk rileks dan melonggar saat diangkat, mirip dengan boneka ragdoll, dan sangat penyayang.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/siam.jpeg",
          name: "Siam",
          desc:
              '''Siam merupakan kucing dengan bulu pendek, mata biru tajam, dan tubuh yang ramping. Mereka dikenal sebagai kucing vokal yang suka berbicara dan memiliki kepribadian yang aktif serta ramah.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/sphynx.jpg",
          name: "Sphynx",
          desc:
              '''Sphynx merupakan jenis kucing tanpa bulu yang memiliki kulit lembut seperti kulit jeruk. Mereka sering menjadi perhatian dengan penampilan yang unik dan ramah serta cerdas dalam perilaku mereka.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/maine%20coon.jpg",
          name: "Maine Coon",
          desc:
              '''Maine Coon merupakan salah satu kucing terbesar dengan bulu panjang dan ekor berbulu tebal. Mereka memiliki sifat yang ramah, lembut, dan cenderung energik, serta memiliki fisik yang kuat.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/munchkin.jpg",
          name: "Munchkin",
          desc:
              '''Munchkin merupakan jenis kucing dengan tubuh pendek dan kaki yang lebih pendek dari kucing biasa. Mereka memiliki penampilan unik yang lucu dan aktif dalam bermain.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/bengal.png",
          name: "Bengal",
          desc:
              '''Bengal memiliki bulu yang berkilau dengan motif belang yang mirip macan tutul. Mereka aktif, cerdas, dan suka bermain, sering kali memiliki energi yang tinggi.'''),
      Cat(
          urlImage:
              "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/britain%20shorthair.jpg",
          name: "Britain Shorthair",
          desc:
              '''British Shorthair memiliki penampilan gemuk dengan wajah yang bulat dan mata besar. Mereka cenderung tenang, santai, dan mudah diurus, membuat mereka menjadi kucing peliharaan yang populer.''')
    ];

Code pada cats_data.dart merupakan kumpulan data kucing dalam bentuk List. List disini bertipe Cat dan isi dari List ini berupa Cat() kemudian diisi data-data kucing sesuai constructor

---
Code pada home_page.dart

    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'package:google_fonts/google_fonts.dart';

    class HomePage extends StatefulWidget {
      const HomePage({Key? key}) : super(key: key);
    
      @override
      State<HomePage> createState() => _HomePageState();
    }
    
    class _HomePageState extends State<HomePage> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Bab 2',
              style: GoogleFonts.openSans(),
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    'Jenis-jenis Kucing',
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
                ListView.builder(
                  itemCount: cats.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Cat cat = cats[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Image.network(
                                  cat.urlImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                cat.name,
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600)),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(DetailPage(
                            cat: cat,
                          ));
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }
    }
Property body diisi dengan ListView agar halaman dapat bergulis ke bawah dan dibungkus dengan Padding, yang pertama diletakkan pada ListView adalah Text hanya untuk menampilkan tulisan 'Jenis-jenis Kucing', lalu pada bawahnya menggunakan ListView.builder()

ListView.builder mempunyai beberapa property seperti
- itemCount:
Berguna untuk menentukan berapa panjang/jumlah untuk ListView.builder()

- shrinkWrap:
jika shrinkWrap diatur menjadi true ListView.builder akan mengambil ruang sesuai yang diatur, artinya apabila ukuran ListView.builder() sudah diatur maka ListView.builder() tidak akan mengambil ruang lebih dari yang ditentukan.

- physics:
jika physics diatur menjadi NeverScrollableScrollPhysics() maka kemampuan scrolling akan dimatikan pada ListView.builder. Biasanya apabila physics diatur menjadi NeverScrollableScrollPhysics() maka physics diatur enjadi true

- itemBuilder: () {}
itemBuilder digunakan untuk membangun ui nya dengan return Widget. parameter biasanya diisi (context, index) atau bisa juga(_, index). Parameter index biasa digunakan untuk mengakses index urutan data, pada code di atas ditampung di variabel cat

      contoh :  Cat cat = cats[index];
lalu untuk mendapatkan data pada code di atas bisa dengan 

    cat.name
Terletak pada code bagian

    Text(
      cat.name,
      style: GoogleFonts.openSans(
        textStyle: const TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.w600
        )
      ),
    )


---
Code pada detail_page.dart

    import 'package:flutter/material.dart';

    class DetailPage extends StatefulWidget {
      const DetailPage({Key? key, required this.cat}) : super(key: key);
      final Cat cat;
    
      @override
      State<DetailPage> createState() => _DetailPageState();
    }
    
    class _DetailPageState extends State<DetailPage> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.cat.name),
          ),
          body: Material(
            child: ListView(
              children: [
                Image.network(widget.cat.urlImage),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text(
                    widget.cat.desc,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
Pada detail_page terdapat class DetailPage(), berfungsi untuk menampilkan detail dari data, pada HomePage hanya menampilkan preview dan pada halaman ini menampilkan lengkap detail data. Class DetailPage mempunyai constructor untuk mengambil data.

Pada ListView.builder yang berada pada class HomePage terdapat InkWell(). InkWell() berfungsi sama seperti GestureDetector() untuk melakukan suatu aksi. Ketika user *klik* pada salah satu isi ListView.builder() maka halaman berpindah dan menampilkan data detailnya.

    onTap: () {
      Get.to(DetailPage(cat: cat,));
    },

Dengan Get.to(DetailPage(cat: cat,)); maka halaman akan berpindah, karena class DetailPage mempunyai constructor yang meminta untuk mengisi cat maka constructor tersebut diisi dengan variabel cat

variabel cat yang dimaksud untuk mengisi constructor adalah

    Cat cat = cats[index];

  ---
## Laporan Pendahuluan(LP)
1. Jelaskan apa itu Android
   
2. Jelaskan apa itu data dummy
 
3. Jelas apa itu ListView

4. Berikan perbedaan singkat antara GestureDetector dan InkWell

## Laporan Akhir(LA)
1. Berikan kesimpulan singkat pada Bab 2
