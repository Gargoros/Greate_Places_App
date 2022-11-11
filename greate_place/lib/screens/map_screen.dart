import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:greate_place/helpers/location_api_key.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 53.893009, longitude: 27.567444),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Map"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/$MAPBOX_USERNAME/claa8yxh0000414plvlvair9l/tiles/256/{z}/{x}/{y}@2x?access_token=$MAPBOX_API_KEY',
            additionalOptions: {
              'accessToken': MAPBOX_API_KEY,
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
        ],
      ),
    );
  }
}
