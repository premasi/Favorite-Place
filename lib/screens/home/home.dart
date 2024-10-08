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
  late Future<void> _placeFuture;
  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(addProvider.notifier).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final listFavorite = ref.watch(addProvider);
    Widget content = FutureBuilder(
      future: _placeFuture,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: listFavorite.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => Detail(
                              data: listFavorite[index],
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(listFavorite[index].image),
                      ),
                      title: Text(
                        listFavorite[index].title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Subtitle address",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
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
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16), child: content),
    );
  }
}
