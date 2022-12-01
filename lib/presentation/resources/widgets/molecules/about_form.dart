import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

// Flutter documentation: https://docs.flutter.dev/cookbook/forms/text-field-changes
class AboutFormWidget extends StatefulWidget {
  const AboutFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutFormWidget> createState() => _AboutFormWidgetState();
}

// * this is the corresponding State class.
// * this class holds data related to the "About Widget".
class _AboutFormWidgetState extends State<AboutFormWidget> {
  // Creating a text controller, that is used later to retrieve
  // the current value value of the TextFormField.
  final myController = TextEditingController();

  // ! Testing something --------------------------------------------
  String storedUserInput =
      "Hello World. "; // ! This variable should come from database

  // getter
  String get getStoredUserInput {
    return storedUserInput; // TODO: Get from DB
  }

  // setter
  set setStoredUserInput(String text) {
    storedUserInput = text;

    // TODO: Implement "push to DB"
  }
  // ! --------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    myController.text = getStoredUserInput; // initialize with value from DB

    // * Start listening to changes
    myController.addListener(
      () {
        _updateText();
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    myController.dispose(); // * removes the listener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ThemeTextH2(
              textString: "About Me",
              textColor: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller:
              myController, // * supplying the controller to allow listening for changes
          maxLength: 250,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Click to edit bio...",
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: TravalongColors.placeholder_text,
              ),
            ),
            filled: true,
            fillColor: TravalongColors.primary_30,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: TravalongColors.secondary_10,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: TravalongColors.primary_30_stroke,
                width: 1.5,
              ),
            ),
          ),
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  // * function to update database based on newest input
  void _updateText() {
    var currentUserInput = myController.text;

    // * check if userInput is updated and update database
    if (getStoredUserInput != currentUserInput) {
      // ! should print old database value
      //print("old input: $getStoredUserInput"); // debug

      setStoredUserInput = currentUserInput; // set new value

      // ! should print updated input value
      //print("new input: $getStoredUserInput"); // debug

      // TODO: update database with new value
    }
  }
}
