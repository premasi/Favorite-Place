import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});

  final void Function(File image) onSelectImage;

  @override
  State<StatefulWidget> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void takePicture() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickImage.path);
    });

    widget.onSelectImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: takePicture,
      label: const Text("Take Picture"),
      icon: const Icon(Icons.camera),
    );

    if (selectedImage != null) {
      content = GestureDetector(
        onTap: takePicture,
        child: Image.file(
          selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.primary)),
        width: double.infinity,
        height: 250,
        alignment: Alignment.center,
        child: content);
  }
}
