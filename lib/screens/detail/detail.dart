import 'package:favorite_places/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Detail extends ConsumerWidget {
  const Detail({super.key, required this.data});
  final FavoriteModel data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, // Change this to the color you want
          ),
          title: const Text(
            "Detail",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Image.file(
              data.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          ],
        ));
  }
}
