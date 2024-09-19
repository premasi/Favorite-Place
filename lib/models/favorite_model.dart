import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class FavoriteModel {
  FavoriteModel({
    required this.title,
    required this.image,
    // required this.location,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final File image;
  // final FavoriteLocation location;
}

class FavoriteLocation {
  const FavoriteLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
  final double latitude;
  final double longitude;
  final String address;
}
