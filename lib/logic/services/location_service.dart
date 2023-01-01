import 'package:geolocator/geolocator.dart';

class LocationServices {
  // * ask device for location permission
  Future<void> getLocationPermissions() async {
    // check if location service is enabled on user device
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    // check/get permission for location access
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, cannot request permissions.");
    }
  }
}
