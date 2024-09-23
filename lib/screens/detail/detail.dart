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
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.red, Colors.blue],
                            begin: AlignmentDirectional.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Text(
                        data.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
