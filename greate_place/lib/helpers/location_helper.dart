import "./location_api_key.dart";

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
  }
}

// https://api.mapbox.com/styles/v1/mikhailzhacko/claa8b2e400ka15phov7spmej.html?title=view&access_token=pk.eyJ1IjoibWlraGFpbHpoYWNrbyIsImEiOiJjbGFhNjlkMDkwNHNtM3VwbDIzcndzZW96In0.IVRy7GETDisJzYXUNkT4wg&zoomwheel=true&fresh=true#2/37.75/-92.25