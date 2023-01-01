import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/services/location_service.dart';
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
  // * creates instance of firebase_controller class
  FirebaseController fController = FirebaseController();

  String _userLocation = "";

  @override
  void initState() {
    super.initState();

    fController.getDocFieldData(UserData.city).then((city) {
      fController.getDocFieldData(UserData.country).then((country) {
        setState(() {
          _userLocation = "$city, $country";
          //debugPrint(_userLocation);
        });
      });
    });
  }

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
        Row(
          children: [
            ThemeContainer(
              height: 40,
              customWidth: true,
              width: 335,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ThemeText(
                  textString: _userLocation,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: TravalongColors.primary_text_bright,
                ),
              ),
            ),
            //const Spacer(), // moves button to right side
            const SizedBox(width: 2),
            ElevatedButton(
              // TODO: change ElevatedButton to custom button
              onPressed: () async {
                await LocationServices().getLocationPermissions();

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
                  // update database with _userLocation
                  fController.setDocFieldData(UserData.city, city);
                  fController.setDocFieldData(UserData.country, country);

                  // refresh _userLocation display text
                  fController.getDocFieldData(UserData.city).then((city) {
                    fController
                        .getDocFieldData(UserData.country)
                        .then((country) {
                      setState(() {
                        _userLocation = "$city, $country";
                        //debugPrint(_userLocation);
                      });
                    });
                  });
                });
              },
              child: const Icon(Icons.update),
            ),
          ],
        ),
      ],
    );
  }
}
