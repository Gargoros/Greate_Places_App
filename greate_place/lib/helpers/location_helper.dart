import "./location_api_key.dart";

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
  }
}
