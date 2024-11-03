import 'package:flutter/material.dart';
import 'package:news_app/api.dart';
import 'package:news_app/model/res_berita.dart';

class DetailBerita extends StatelessWidget {
  static const String routeName = '/detail_berita';

  const DetailBerita({super.key});

  @override
  Widget build(BuildContext context) {
    Berita berita = ModalRoute.of(context)!.settings.arguments as Berita;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Berita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.network(
              "$imageUrl${berita.gambarBerita}",
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 8),
            Text(
              '${berita.judul}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${berita.isiBerita}',
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
