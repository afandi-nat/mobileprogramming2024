import 'package:flutter/material.dart';
import 'package:get_data_user/model/model.dart';
import 'package:get_data_user/repository.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> listUser = [];
  Repository repository = Repository();

  getData() async {
    listUser = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Data API'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listUser[index].name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(listUser[index].sex)
                  ],
                ));
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: listUser.length),
    );
  }
}
