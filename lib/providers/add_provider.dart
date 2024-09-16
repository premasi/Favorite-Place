import 'package:favorite_places/models/favorite_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProviderNotifier extends StateNotifier<List<FavoriteModel>> {
  AddProviderNotifier() : super([]);

  void addData(FavoriteModel data) {
    state = [...state, data];
  }
}

final addProvider =
    StateNotifierProvider<AddProviderNotifier, List<FavoriteModel>>((ref) {
  return AddProviderNotifier();
});
