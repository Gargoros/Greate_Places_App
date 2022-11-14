import 'package:flutter/material.dart';
import 'package:location/location.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude!, locationData.longitude!);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => const MapScreen(
                  isSelecting: true,
                )));

    // ignore: unnecessary_null_comparison
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Current Location"),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                )),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
