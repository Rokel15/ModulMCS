import 'package:bab_6/DetailPage.dart';
import 'package:bab_6/fetchData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<Album> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body:
      FutureBuilder(
        future: fetchAlbum(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return buildView(snapshot.data as List<Album>);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget buildView(List<Album> albums){
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: MasonryGridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
        itemCount: albums.length,
        itemBuilder: (context, index){
          final album = albums[index];
          return InkWell(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    albums[index].urlToImage, //mengambil atau mengakses data cara 1
                    fit: BoxFit.cover,
                  ),
                  Text(
                    '${album.title}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),//mengambil atau mengakses data cara 2, lebih recomended
                  ),
                  Text('${album.publishedAt}')
                ],
              ),
            ),
            onTap: (){
              Get.to(DetailPage(album: album,));
            },
          );
        },
      ),
    );
  }
}
