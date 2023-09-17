# BAB 3
# State Management Business Logic Component (Bloc)
### Pada bab ini kita akan mempelajari contoh dari Satte Management Bloc
Pada bab ini kita akan belajar bagaimana mmebuat Bloc, Business logic component (Bloc) merupakan salah satu dari pengelolaan state dalam mengembangkan aplikasi flutter. Bloc menjadi pemisah untuk mengatur ui dan data sehingga memungkinkan pengembang aplikasi dalam mengelola state. Terdapat 2 konsep penting yang ada pada Bloc yaitu Event dan State

1. Event
Event adalah pemicu/tindakan yang akan mempengaruhi state, bisa dibilang Event adalah instruksi untuk mempengaruhi suatu keadaan.

2. State
State adalah keadaan atau kondisi. State menggambarkan tampilan dan State berubah sesuai sebagai respon terhadap Event yang diterima.

Maksud dari event dan state dalam BLoC adalah untuk memisahkan bagaimana peristiwa dan tindakan mempengaruhi keadaan aplikasi. Event digunakan untuk memicu perubahan dalam state. Ketika event diterima, BLoC akan memprosesnya dan menghasilkan state yang sesuai. State ini kemudian diberikan ke tampilan untuk di-render.
## Praktikum Bab 3
Pada bab ini kita akan menggunakan studi yang sudah ada bab 2 namun menambahkan State Management Bloc di dalamnya, dengan State Management Bloc aplikasi pada bab 2 akan dibuat tampilan loading selama beberapa detik ketika aplikasi dijalankan, setelah tampilan loading selama beberapa detik kemudian muncul informasi tentang beberapa kucing sama seperti pada bab 2. Kita akan membuat kondisi ini bernama isLoading dan isLoaded. State kita atur untuk dalam kondisi isLoading(menampilkan widget CircularProgressIndicator()) terlebih dahulu kemudian setelah itu State kita atur dlam kondisi isLoaded(menampilkan informasi kucing).

Tampilan ketika aplikasi dijalankan/dibuka
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/isLoading.PNG" alt="Teks Pengganti">
</div>
Ketika aplikasi dibuka/dijalankan maka aknan menampilkan CircularProgressIndicator() selama beberapa detik sebelum menampilkan informasi tentang kucing. Kondisi ini kita beri nama isLoading

---
Tampilan aplikasi setelah isLoading, yaitu isLoaded
<div align="center">
  <img src="https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%203/isLoaded.PNG" alt="Teks Pengganti">
</div>
Pada kondisi isLoaded aplikasi menampilkan informasi tentang kucing.

---
Pertama-tama tambahkan dependencies berikut

    bloc: ^8.1.2
    flutter_bloc: ^8.1.3
    get: ^4.6.5
    google_fonts: ^5.1.0

Cek versi paling update di [https://pub.dev/](https://pub.dev/), cari dan salin ke dalam pubspec.yaml

Jika pengembang menggunakan Visual Studio Code untuk menulis code maka pengembang bisa unduh extension bloc dengan nama publisher Felix Angelov atau bisa diunduh manual pada [marketplace Visual Studio Code](https://marketplace.visualstudio.com/), klik [link ini](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc) untuk menuju langsung ke tempat mengunduh extension bloc dengan nama publisher Felix Angelov.

Keuntungan dari extension ini adalah pengembang bisa generate otomatis folder dan file untuk kebutuhan Bloc. folder dan file untuk kebutuhan Bloc akan digenerate secara terstruktur sehingga Bloc siap edit dan pakai. caranya 


