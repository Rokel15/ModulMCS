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
