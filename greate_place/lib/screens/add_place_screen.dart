import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/place.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';

  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: "Title"),
                      controller: _titleController,
                      onSubmitted: (_) => {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: const Text(
                "Add Place",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)))
        ],
      ),
    );
  }
}
