import 'package:flutter/material.dart';
import 'dart:io';
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart" as syspath;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final _picker = ImagePicker();

  Future<void> _takePicture() async {
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    var imagePath = File(imageFile.path);

    setState(() {
      _storedImage = imagePath;
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imagePath.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No image taken",
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: TextButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text("Take Picture"),
                onPressed: _takePicture,
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor)))
      ],
    );
  }
}
