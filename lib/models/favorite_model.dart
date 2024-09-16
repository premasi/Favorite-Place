import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoriteModel {
  FavoriteModel({required this.title}) : id = uuid.v4();
  final String id;
  final String title;
}
