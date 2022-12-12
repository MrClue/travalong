import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_container.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String _userLocation = "";
  //late String lat;
  //late String long;

  /*
  // * Getting Current User Location
  Future<Position> _getCurrentLocation() async {
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

    // when permissions are granted we can
    // get the current position of device
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;

    /*return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);*/
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            ThemeTextH2(
              textString: "Location",
              textColor: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        ThemeContainer(
          height: 40,
          child: Row(
            children: [
              ThemeText(
                textString: _userLocation, // TODO: fetch device location
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textColor: TravalongColors.primary_text_bright,
              ),
              const Spacer(), // moves button to right side
              ElevatedButton(
                // TODO: change ElevatedButton to custom button
                onPressed: () async {
                  // TODO: move logic to "Domain" layer

                  // check if location service is enabled on user device
                  bool serviceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (!serviceEnabled) {
                    return Future.error("Location services are disabled.");
                  }

                  // check/get permission for location access
                  LocationPermission permission =
                      await Geolocator.checkPermission();

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

                  // when permissions are granted we can
                  // get the current position of device
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  // get city and country based on coordinates
                  List<Placemark> placemarks = await GeocodingPlatform.instance
                      .placemarkFromCoordinates(
                          position.latitude, position.longitude);

                  // Get the first placemark from the list
                  Placemark placemark = placemarks[0];

                  // Store the city and country in a string
                  String? city = placemark.locality;
                  String? country = placemark.country;

                  setState(() {
                    _userLocation = '$city, $country';
                  });

                  // todo: update database with _userLocation
                },
                child: const Icon(Icons.update),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
