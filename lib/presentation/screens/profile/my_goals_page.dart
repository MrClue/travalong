import "package:flutter/material.dart";
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

import '../../../data/model/user.dart';
import '../../../logic/controller/firebase_controller.dart';
import '../../resources/widgets/molecules/confirm_button.dart';
import '../../resources/widgets/molecules/page_text.dart';

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const ThemeTopBar(
        title: 'My Goals',
        backArrow: BackArrow(),
        enableCustomButton: false,
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: Column(
          children: [
            const PageTextTopCenter(
              textNormal:
                  "Set travel goals for yourself, and keep track of your progress. ",
              textBold: "This is only visible to you.",
            ), // ! text skal ændres
            TravelGoalsSelector(),
          ],
        ),
      ),
    );
  }
}

class SelectableCountries {
  final List<String> countries = [
    "Denmark",
    "Norway",
    "Sweden",
  ];
}

class TravelGoalsSelector extends StatefulWidget {
  @override
  TravelGoalsSelectorState createState() => TravelGoalsSelectorState();
}

class TravelGoalsSelectorState extends State<TravelGoalsSelector> {
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedValues = [];

  final selectableOptions = SelectableCountries();
  String _searchQuery = ""; // Initialize _searchQuery

  FirebaseController fController = FirebaseController();

  bool _valuesChanged = false; // ! ConfirmButton color checker

  void _saveSelectedValues() {
    // save _selectedValues to database
    fController.setDocFieldData(UserData.travelgoals, _selectedValues);
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
    fController.getDocFieldData(UserData.travelgoals).then((travelgoals) {
      setState(() {
        // Replace the first occurrence of "[]" with an empty string
        travelgoals = travelgoals.replaceFirst("[]", "");

        addToSelectedValues(travelgoals);
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
              hintText: "Search travel destinations",
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
                          for (var option in selectableOptions.countries.where(
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
