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




