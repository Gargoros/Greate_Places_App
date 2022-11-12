import 'package:http/http.dart' as http;
import 'dart:convert';
import "./location_api_key.dart";

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$MAPBOX_API_KEY');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
