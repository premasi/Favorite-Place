import 'dart:convert';

import 'package:favorite_places/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(FavoriteLocation location) onSelectLocation;

  @override
  State<StatefulWidget> createState() {
    return LocationInputState();
  }
}

class LocationInputState extends State<LocationInput> {
  FavoriteLocation? pickedLcoation;
  var isLoading = false;

  String get locationImage {
    if (pickedLcoation == null) {
      return "";
    }
    final lat = pickedLcoation!.latitude;
    final long = pickedLcoation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$long&key=AIzaSyDY4uBAQCBz8DFJFPp8BCUH1CwkRgdjW5w';
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isLoading = true;
    });
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;

    if (lat == null || long == null) {
      return;
    }

    // final url = Uri.parse(
    //     "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyDY4uBAQCBz8DFJFPp8BCUH1CwkRgdjW5w");
    // final response = await http.get(url);
    // final resData = json.decode(response.body);
    // final address = resData["results"][0]["formatted_address"];
    setState(() {
      pickedLcoation = FavoriteLocation(
        latitude: lat,
        longitude: long,
        address: "",
      );
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    );
    if (pickedLcoation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (isLoading) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).colorScheme.primary)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              label: const Text("Current location"),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text("Select on map"),
              icon: const Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}
