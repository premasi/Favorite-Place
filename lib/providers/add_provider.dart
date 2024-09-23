import 'package:favorite_places/models/favorite_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'favorite.db'),
      onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE favorites(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
  }, version: 1);
  return db;
}

class AddProviderNotifier extends StateNotifier<List<FavoriteModel>> {
  AddProviderNotifier() : super([]);

  Future<void> loadFavorites() async {
    final db = await _getDatabase();
    final data = await db.query("favorites");
    final places = data
        .map(
          (row) => FavoriteModel(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();

    state = places;
  }

  void addData(FavoriteModel data) async {
    final db = await _getDatabase();
    db.insert(
      "favorites",
      {'id': data.id, 'title': data.title, 'image': data.image.path},
    );
    state = [...state, data];
  }
}

final addProvider =
    StateNotifierProvider<AddProviderNotifier, List<FavoriteModel>>((ref) {
  return AddProviderNotifier();
});
