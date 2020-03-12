import 'package:geolocator/geolocator.dart';

class Location {
  final double latitude;
  final double longitude;

  Location({this.latitude, this.longitude});

  factory Location.getLocation(double lat, double long) {
    return Location(
      latitude: lat,
      longitude: long,
    );
  }

  static Future<Location> currentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    return Location.getLocation(position.latitude, position.longitude);
  }

  static Future<double> nearby(double endLatitude, double endLongitude) async {
    Location location = await Location.currentPosition();
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

    double nearby = await geolocator.distanceBetween(
        location.latitude, location.longitude, endLatitude, endLongitude);

    return nearby;
  }

  static Future<Placemark> address() async {
    Location location = await Location.currentPosition();
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        location.latitude, location.longitude);
    Placemark place = p[0];
    return place;
  }
}
