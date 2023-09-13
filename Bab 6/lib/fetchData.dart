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

// Future<List<Album>> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'https://newsapi.org/v2/top-headlines?country=id&apiKey=7558fd63ad6b4008a0aceeedb8f27002'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body)) as List<Album>;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
