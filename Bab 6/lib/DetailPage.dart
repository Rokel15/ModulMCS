import 'package:flutter/material.dart';
import 'fetchData.dart';

class DetailPage extends StatefulWidget {
  Album album;

  DetailPage({
    required this.album,
  });

  @override
  State<DetailPage> createState() => _DetailPageState(album: album);
}

class _DetailPageState extends State<DetailPage> {
  Album album;

  _DetailPageState({
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page}'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${album.title}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.justify,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${album.author}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          
          Image.network(
            album.urlToImage,
            width: double.infinity,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${album.description}'),
          ),
        ],
      ),
    );
  }
}
