import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

class InterestsSubpage extends StatelessWidget {
  const InterestsSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const ThemeTopBar(
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
              child: const PageText(),
            ),
            const SizedBox(height: 12),
            //const InterestsWidget(),
            //const Spacer(), // fills the remaining space
            //const ConfirmButton()
            MyForm(),
          ],
        ),
      ),
    );
  }
}

// ! testing another selectable
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

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _selectedValues = [];

  final selectableOptions = SelectableOptions();
  String _searchQuery = ""; // Initialize _searchQuery

  void _saveSelectedValues() {
    // TODO: save _selectedValues to database
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
            height: 325, // todo: dont make height static
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
                                    _selectedValues.add(option);
                                  } else {
                                    _selectedValues.remove(option);
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
            selectedValues: _selectedValues,
          ),
        ],
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function onSave;
  final List<String> selectedValues; // Add selectedValues constructor argument

  const ConfirmButton({
    Key? key,
    required this.formKey,
    required this.onSave,
    required this.selectedValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        selectedValues.isNotEmpty // Determined color based on selectedValues
            ? TravalongColors.secondary_10
            : TravalongColors.primary_30;
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 55,
        width: 355,
        decoration: BoxDecoration(
          color: color, // Use determined color
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          border: Border.all(
            color: TravalongColors.primary_30_stroke,
            width: 1.5,
          ),
        ),
        child: const ThemeText(
          textString: "CONFIRM",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
        ),
      ),
      onTap: () {
        if (formKey.currentState!.validate()) {
          // assert not null (!)
          formKey.currentState?.save(); // null-safe operator (?)
          onSave(); // call onSave callback
        }
      },
    );
  }
}

class PageText extends StatelessWidget {
  const PageText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: GoogleFonts.poppins(
          fontSize: 16.0,
          color: Colors.black,
        ),
        children: const <TextSpan>[
          TextSpan(
              text:
                  'Please select what interests and hobbies suits you the best. '),
          TextSpan(
              text: 'This will help you find others with common interests.',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
