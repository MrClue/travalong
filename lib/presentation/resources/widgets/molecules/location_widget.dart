import 'package:flutter/material.dart';
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
  /*
  String userLocation = "Current Location";
  late String lat;
  late String long;

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
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
  */

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
            children: const [
              ThemeText(
                textString: "City, Country", // TODO: fetch device location
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textColor: TravalongColors.primary_text_bright,
              ),
            ],
          ),
        ),

        /*
        Text(
          userLocation,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            _getCurrentLocation().then((position) {
              lat = "${position.latitude}";
              long = "${position.longitude}";

              // update values
              setState(() {
                userLocation = "Lat: $lat, Long: $long";
              });

              // * video 1:18
            });
          },
          child: const Text("Get Current Location"),
        ),
        */
      ],
    );
  }
}
