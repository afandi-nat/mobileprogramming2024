import 'package:flutter/material.dart';
import 'package:news_app/model/res_berita.dart';

class DetailBerita extends StatelessWidget {
  static const String routeName = '/detail_berita';
  final Berita listBerita;
  const DetailBerita({super.key, required this.listBerita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(
              "imageUrl${listBerita.gambarBerita}",
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 8),
            Text(
              '${listBerita.judul}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${listBerita.isiBerita}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
