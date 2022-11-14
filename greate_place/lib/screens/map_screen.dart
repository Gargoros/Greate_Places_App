import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../helpers/location_api_key.dart';
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
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You Map"),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
          onLongPress: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                }
              : null,
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
          MarkerLayer(
            markers: _pickedLocation == null
                ? []
                : [
                    Marker(
                      point: _pickedLocation!,
                      builder: (ctx) => Icon(
                        Icons.location_on_sharp,
                        size: 50,
                      ),
                    ),
                  ],
          )
        ],
      ),
    );
  }
}
