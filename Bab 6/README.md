# BAB 6
# News Api
### Pada bab ini kita akan membuat aplikasi untuk menampilkan berita yang didapatkan dari application programming interface(API).

---
### Application Programming Interface(API)
API adalah cara agar sebuah perangkat lunak atau lebih dapat berkomunikasi dengan server berisikan data-data. Data-data pada server diambil dan digunakan oleh pengembang aplikasi untuk diolah, API menjadi perantara developer untuk mengambil data-data pada server. Jika dianalogikan pada kegiatan di restoran maka seperti pelanggan yang melihat daftar menu makanan dan memesan makanan kepada restoran tersebut lalu restoran memberikannya, pelanggan tidak tahu bagaimana caranya sebuah makanan disiapkan, begitu juga developer tidak tahu bagaimana data tersebut disiapkan tapi yang penting adalah data didapat oleh developer.
## Praktikum Bab 6
Pada bab ini kita akan mengambil data-data berita menggunakan newsapi. Untuk mendapatkan api dari newsapi buka website [https://newsapi.org/](https://newsapi.org/) dan disana terdapat beberapa api yang bisa digunakan untuk digunakan seperti contoh berikut :

![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi1.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi2.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi3.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi4.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi5.PNG)

Dari website tersebut dapat dilihat terdapat beberapa api berita, dan tiap api memiliki berita dengan tema yang berbeda-beda.

Selanjutnya adalah bagaimana cara mengambil data-data berita dari api. Untuk melihat dokumentasi bagaimana cara mengambil data dari internet buka [https://docs.flutter.dev/](https://docs.flutter.dev/). Cari pada kolom pencarian 'fetch data' lalu hasil pencarian akan menunjukan 'fetch data from the internet' dan klik, setelah diklik akan menuju halaman [https://docs.flutter.dev/cookbook/networking/fetch-data](https://docs.flutter.dev/cookbook/networking/fetch-data). Pada halaman ini menunjukan dokumentasi dan menggambarkan bagaimana data diambil dari internet.

Setup project baru pada android studio lalu berikan internet permission AndroidManifest.xml. Path file AndroidManifest.xml terletetak di app > scr > main > AndroidManifest.xml. Tambahkan di atas <aplication...>.

    <manifest xmlns:android="http://schemas.android.com/apk/res/android">
      <uses-permission android:name="android.permission.INTERNET" />
    
      <aplication...>
    </manifest>
Tambahkan packages berikut

- http: ^1.1.0 (versi bisa berubah, cek di[https://pub.dev/](https://pub.dev/))
- get: ^4.6.6 (versi bisa berubah, cek di[https://pub.dev/](https://pub.dev/))
- flutter_staggered_grid_view: ^0.7.0 (versi bisa berubah, cek di[https://pub.dev/](https://pub.dev/))

http dibutuhkan untuk melakukan permintaan HTTP, dalam kasus mengambil data dari web server atau interaksi dengan API. Packages get akan digunakan untuk navigasi saja dan - flutter_staggered_grid_view digunakan untuk membuat setiap item pada tampilan grid berbeda-beda seperti pada gambar berikut :

<table>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/letsar/flutter_staggered_grid_view/master/docs/images/staggered.png" alt="Staggered Grid View" width="200"/>
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/letsar/flutter_staggered_grid_view/master/docs/images/staggered_example.png" alt="Staggered Grid View" width="200"/>
    </td>
  </tr>
</table>



