import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: TravalongColors.neutral_60,
        appBar: const TopBarDone(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: const [
              SizedBox(
                height: 30,
              ),
              AboutFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

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
          children: [
            Text(
              "About Me",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            /*IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
              ),
            ),*/
          ],
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
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
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
      print("old input: $getStoredUserInput"); // debug

      setStoredUserInput = currentUserInput; // set new value

      // ! should print updated input value
      print("new input: $getStoredUserInput"); // debug

      // TODO: update database with new value
    }
  }
}

class TopBarDone extends StatelessWidget implements PreferredSizeWidget {
  const TopBarDone({
    Key? key,
  }) : super(key: key);

  double get topbarHeight => 65; // is method to avoid having it in constructor

  @override
  Size get preferredSize => Size.fromHeight(topbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TravalongColors.neutral_60,
      toolbarHeight: topbarHeight,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          width: 1.5,
        ),
      ),
      automaticallyImplyLeading: false, // disables default back arrow
      title: Text(
        "My Profile",
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          constraints: const BoxConstraints.expand(width: 80),
          icon: Text(
            'Done',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: TravalongColors.secondary_10),
          ),
          onPressed: () {
            // TODO: First save all data

            //hideKeyboard(context); // hide keyboard

            Navigator.pop(context); // return to previous page
          },
        ),
      ],
    );
  }
}
