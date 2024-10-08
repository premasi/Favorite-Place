import 'dart:io';

import 'package:favorite_places/models/favorite_model.dart';
import 'package:favorite_places/providers/add_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class Add extends ConsumerStatefulWidget {
  const Add({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AddState();
  }
}

class AddState extends ConsumerState {
  final formKey = GlobalKey<FormState>();
  var inputTitle = "";
  File? selectedImage;
  FavoriteLocation? selectedLocation;
  var isSending = false;
  void saveItem() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isSending = true;
      });
      formKey.currentState!.save();
      if (selectedImage != null) {
        final appPath = await syspath.getApplicationDocumentsDirectory();
        final filename = path.basename(selectedImage!.path);
        final copyImage =
            await selectedImage!.copy('${appPath.path}/$filename');
        final data = FavoriteModel(
          title: inputTitle,
          image: copyImage,
        );
        ref.read(addProvider.notifier).addData(data);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change this to the color you want
        ),
        title: const Text(
          "Add new favorite place",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 50,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length > 50) {
                      return "Title cannot be empty and maximun characters is 50";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    inputTitle = newValue!;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ImageInput(
                  onSelectImage: (image) {
                    selectedImage = image;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                LocationInput(
                  onSelectLocation: (location) {
                    selectedLocation = location;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isSending
                          ? null
                          : () {
                              formKey.currentState!.reset();
                            },
                      child: const Text("Reset"),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: isSending ? null : saveItem,
                      child: isSending
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Add item"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
