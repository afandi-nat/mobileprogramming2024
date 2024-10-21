import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api.dart';
import 'package:news_app/detail_berita.dart';
import 'package:news_app/model/res_berita.dart';

class BeritaPage extends StatefulWidget {
  static const String routeName = '/berita_page';
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  bool isLoading = false;
  List<Berita> listBerita = [];

  Future<ResBerita?> getBerita() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse("${baseUrl}getBerita.php"));
      List<Berita>? data = resBeritaFromJson(res.body).data;
      setState(() {
        isLoading = false;
        listBerita = data ?? [];
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita'),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            )
          : ListView.builder(
              itemCount: listBerita.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, DetailBerita.routeName,
                          arguments: listBerita[index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            '$imageUrl${listBerita[index].gambarBerita}',
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          ),
                          ListTile(
                            title: Text(
                              '${listBerita[index].judul}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
