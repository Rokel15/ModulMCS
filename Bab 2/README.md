# BAB 2
# Dinamis UI
### Pada bab ini akan diperkenalkan cara membuat ui secara dinamis menggunakan ListView.Builder(), sebelumnya pada bab 1 kita sudah menggunakan ListView untuk menampung beberapa widget, dengan ListView.Builder akan *generate* komponen-komponen yang diatur sedemikian rupa sebanyak data yang tersedia. Data yang tersedia bisa diambil dari database ataupun data dummy. Namun pada bab 2 ini kita akan membuat dinamis ui yang mana datanya berasal dari data dummy.

## Praktikum Bab 2
Tampilan aplikasi yang akan dibangun

Tampilan Awal dengan ListView.Builder
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

jkkj
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

---



