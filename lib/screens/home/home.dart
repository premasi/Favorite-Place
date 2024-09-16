import 'package:favorite_places/providers/add_provider.dart';
import 'package:favorite_places/screens/add/add.dart';
import 'package:favorite_places/screens/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<Home> createState() {
    return HomeState();
  }
}

class HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final listFavorite = ref.watch(addProvider);
    Widget content = Expanded(
      child: ListView.builder(
          itemCount: listFavorite.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Detail(
                        data: listFavorite[index],
                      ),
                    ),
                  );
                },
                child: Text(
                  listFavorite[index].title,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
    );

    if (listFavorite.isEmpty) {
      content = const Center(
        child: Text(
          "Data is empty",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const Add(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: content),
    );
  }
}
