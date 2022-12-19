import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

import '../../../data/model/user.dart';
import '../../resources/widgets/molecules/confirm_button.dart';
import '../../resources/widgets/molecules/page_text.dart';

class InterestsSubpage extends StatelessWidget {
  const InterestsSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: ThemeTopBar(
        backArrow: BackArrow(),
        title: "Interests & Hobbies",
        enableCustomButton: false,
        customButtonWidget: Text(""),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: Column(
          children: [
            Container(
              //color: Colors.black12, // ! for debug
              child: const PageTextTopCenter(
                textNormal:
                    'Please select what interests and hobbies suits you the best. ',
                textBold:
                    'This will help you find others with common interests.',
              ),
            ),
            const SizedBox(height: 12),
            //const InterestsWidget(),
            //const Spacer(), // fills the remaining space
            //const ConfirmButton()
            InterestsSelector(),
          ],
        ),
      ),
    );
  }
}

class SelectableOptions {
  final List<String> options = [
    "Astronomy",
    "Art",
    "Biking",
    "Board games",
    "Cars",
    "Chess",
    "Coding",
    "Comedy",
    "Collecting",
    "Concerts",
    "Cooking",
    "Cryptocurrency",
    "Dancing",
    "Drawing",
    "Entrepreneurship",
    "Fashion",
    "Fishing",
    "Fitness",
    "Food",
    "Gaming",
    "Gardening",
    "Go",
    "Graphic design",
    "Hiking",
    "Investing",
    "Knitting",
    "Magic",
    "Magic tricks",
    "Martial arts",
    "Movies",
    "Music",
    "Music production",
    "Nature",
    "Painting",
    "Personal finance",
    "Photography",
    "Model building",
    "Motorcycles",
    "Movies",
    "Painting",
    "Photography",
    "Quilting",
    "Reading",
    "Sculpting",
    "Sewing",
    "Skating",
    "Snowboarding",
    "Sports",
    "Stock trading",
    "Surfing",
    "Theater",
    "Technology",
    "Traveling",
    "Video editing",
    "Volunteering",
    "Web design",
    "Writing"
  ]; //["Option 1", "Option 2", "Option 3"];

  /*SelectableOptions() {
    for (int i = 0; i < 10; i++) {
      options.add("Option " + (i + 1).toString());
    }
  }*/
}

class InterestsSelector extends StatefulWidget {
  @override
  InterestsSelectorState createState() => InterestsSelectorState();
}

class InterestsSelectorState extends State<InterestsSelector> {
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedValues = [];

  final selectableOptions = SelectableOptions();
  String _searchQuery = ""; // Initialize _searchQuery

  FirebaseController fController = FirebaseController();

  bool _valuesChanged = false; // ! ConfirmButton color checker

  void _saveSelectedValues() {
    // save _selectedValues to database
    fController.setDocFieldData(UserData.interests, _selectedValues);
    setState(() {
      _valuesChanged = false; // ! reset button color back to default
    });
  }

  void addToSelectedValues(String value) {
    if (value != "" && value != "[]") {
      setState(() {
        // Replace all occurrences of "[" and "]" with an empty string
        value = value.replaceAll("[", "").replaceAll("]", "");
        // Split the value string into a list of options
        List<String> options = value.split(", ");
        // Add each option to the _selectedValues list
        options.forEach((option) => _selectedValues.add(option));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // get _selectedValues from database
    fController.getDocFieldData(UserData.interests).then((interests) {
      setState(() {
        // Replace the first occurrence of "[]" with an empty string
        interests = interests.replaceFirst("[]", "");

        addToSelectedValues(interests);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Search for interests", // Add hint text
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2, // ! maybee change
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        children: [
                          // uses options from SelectableOptions class
                          for (var option in selectableOptions.options.where(
                              (option) => option
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase())))
                            // filter based on search
                            CheckboxListTile(
                              title: Text(option),
                              value: _selectedValues.contains(option),
                              onChanged: (value) {
                                setState(() {
                                  if (value != null && value) {
                                    addToSelectedValues(option);
                                    _valuesChanged = true;
                                  } else {
                                    _selectedValues.remove(option);
                                    _valuesChanged = true;
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          ConfirmButton(
            formKey: _formKey,
            onSave: _saveSelectedValues,
            valuesChanged: _valuesChanged,
            //selectedValues: _selectedValues,
          ),
        ],
      ),
    );
  }
}
