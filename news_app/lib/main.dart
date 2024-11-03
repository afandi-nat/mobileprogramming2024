import 'package:flutter/material.dart';
import 'package:news_app/berita_page.dart';
import 'package:news_app/detail_berita.dart';
// import 'package:news_app/detail_berita.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: BeritaPage.routeName,
      routes: {
        BeritaPage.routeName: (context) => const BeritaPage(),
        DetailBerita.routeName: (context) => const DetailBerita()
      },
    );
  }
}
