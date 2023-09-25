# BAB 6
# News Api
### Pada bab ini kita akan membuat aplikasi untuk menampilkan berita yang didapatkan dari application programming interface(API).

---
### Application Programming Interface(API)
API adalah cara agar sebuah perangkat lunak atau lebih dapat berkomunikasi dengan server berisikan data. Data pada server diambil dan digunakan oleh pengembang aplikasi untuk diolah, API menjadi perantara developer untuk mengambil data pada server. Jika dianalogikan pada kegiatan di restoran maka seperti pelanggan yang melihat daftar menu makanan dan memesan makanan kepada restoran tersebut lalu restoran memberikannya, pelanggan tidak tahu bagaimana caranya sebuah makanan disiapkan, begitu juga developer tidak tahu bagaimana data tersebut disiapkan tapi yang penting adalah data didapat oleh developer.
## Praktikum Bab 6
Pada bab ini kita akan mengambil data berita menggunakan newsapi. Untuk mendapatkan api dari newsapi buka website [https://newsapi.org/](https://newsapi.org/) dan disana terdapat beberapa api yang bisa digunakan untuk digunakan seperti contoh berikut :

![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi1.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi2.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi3.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi4.PNG)
![news api](https://github.com/Rokel15/testing_modulMCS/blob/main/Images/bab%204/newsapi5.PNG)

Dari website tersebut dapat dilihat terdapat beberapa api berita, dan tiap api memiliki berita dengan tema yang berbeda-beda.

Selanjutnya adalah bagaimana cara mengambil data berita dari api. Untuk melihat dokumentasi bagaimana cara mengambil data dari internet buka [https://docs.flutter.dev/](https://docs.flutter.dev/). Cari pada kolom pencarian 'fetch data' lalu hasil pencarian akan menunjukan 'fetch data from the internet' dan klik, setelah diklik akan menuju halaman [https://docs.flutter.dev/cookbook/networking/fetch-data](https://docs.flutter.dev/cookbook/networking/fetch-data). Pada halaman ini menunjukan dokumentasi dan menggambarkan bagaimana data diambil dari internet.

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

<p align="center">
  <img src="https://raw.githubusercontent.com/letsar/flutter_staggered_grid_view/master/docs/images/staggered.png" width="400" alt="Gambar 1">
  <br>
  <em>contoh 1</em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/letsar/flutter_staggered_grid_view/master/docs/images/staggered_example.png" width="400" alt="Gambar 2">
  <br>
  <em>contoh 2</em>
</p>

Ukuran setiap item setiap menjadi berbeda-beda, namun kita hanya akan mengatur crossAxisCount: 2 artinya dalam 1 layar item akan generate kesamping hingga berjumlah 2 dan  dengan ukuran lebar yang sama namun panjang berbeda-beda.

setelah menambahkan packages buatlah file baru di dalam folder lib bernama fetchData.dart dan buat code sebagai berikut

    import 'dart:convert';
    import 'package:http/http.dart' as http;
    
    class Source {
      dynamic id;
      dynamic name;
    
      Source({
        required this.id,
        required this.name,
      });
    
      factory Source.fromJson(Map<String, dynamic> json) =>
          Source(id: json["id"], name: json["name"]);
    }
    
    class Album {
      Source source;
      String author;
      String title;
      String description;
      String url;
      String urlToImage;
      DateTime publishedAt;
      String content;
    
      Album(
          {required this.source,
          required this.author,
          required this.title,
          required this.description,
          required this.url,
          required this.urlToImage,
          required this.publishedAt,
          required this.content});
    
      factory Album.fromJson(Map<String, dynamic> json) {
        return Album(
          source: Source.fromJson(json["source"]),
          author: json["author"] ?? "get no author",
          title: json["title"] ?? "get no title",
          description: json["description"] ?? "get no description",
          url: json["url"],
          urlToImage: json["urlToImage"] ??
              'https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png',
          publishedAt: DateTime.parse(
              json["publishedAt"] ?? DateTime.now().toIso8601String()),
          content: json["content"] ?? "get no content",
        );
      }
    }
    
    Future<List<Album>> fetchAlbum() async {
      final response = await http
          .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4e991782cbdf4c97959e69f5b051873b'));
    
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final result = responseBody['articles'] as List;
        final listNews = result.map((e) => Album.fromJson(e)).toList();
        return listNews;
      } else {
        throw Exception('Failed to load album');
      }
    }
Penjelasan :

Di dalam newsapi terdapat body respon berbentuk map, di dalam map tersebut terdapat berbagai key seperti source, author, title, description, url, urlToImage, publishedAt, content dengan isian String kecuali source di dalamnya terdapat map. Oleh karena itu pada code di atas terdapat class model untuk source

    class Source {
      dynamic id;
      dynamic name;
    
      Source({
        required this.id,
        required this.name,
      });
    
      factory Source.fromJson(Map<String, dynamic> json) =>
          Source(id: json["id"], name: json["name"]);
    }

Dan pada class model album dibuat seperti ini

    class Album {
      Source source;
      String author;
      String title;
      String description;
      String url;
      String urlToImage;
      DateTime publishedAt;
      String content;
    
      Album(
          {required this.source,
          required this.author,
          required this.title,
          required this.description,
          required this.url,
          required this.urlToImage,
          required this.publishedAt,
          required this.content});
    
      factory Album.fromJson(Map<String, dynamic> json) {
        return Album(
          source: Source.fromJson(json["source"]),
          author: json["author"] ?? "get no author",
          title: json["title"] ?? "get no title",
          description: json["description"] ?? "get no description",
          url: json["url"],
          urlToImage: json["urlToImage"] ??
              'https://pertaniansehat.com/v01/wp-content/uploads/2015/08/default-placeholder.png',
          publishedAt: DateTime.parse(
              json["publishedAt"] ?? DateTime.now().toIso8601String()),
          content: json["content"] ?? "get no content",
        );
      }
    }

    Future<List<Album>> fetchAlbum() async {
      final response = await http
          .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4e991782cbdf4c97959e69f5b051873b'));
    
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final result = responseBody['articles'] as List;
        final listNews = result.map((e) => Album.fromJson(e)).toList();
        return listNews;
      } else {
        throw Exception('Failed to load album');
      }
    }
Lalu pada function fetchAlbum untuk mengambil data dari newsapi dengan menggunakan http request
