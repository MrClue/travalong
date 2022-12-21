import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:travalong/presentation/screens/search/widgets/date_button.dart';

class SearchStartScreen extends StatefulWidget {
  const SearchStartScreen({super.key});

  @override
  State<SearchStartScreen> createState() => _SearchStartScreenState();
}

const List<String> list = <String>['Male', 'Female', 'Any'];
const List<String> optList = <String>['currently in', 'going to']; // ! not MVP

class _SearchStartScreenState extends State<SearchStartScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(), // Todays date
    end: DateTime.now().add(const Duration(days: 1)), // Tomorrows date
  );

  TextEditingController dateController = TextEditingController();
  String dropdownValue = list.first;
  String optvalue = optList.first;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: 'Search Travelers',
        enableCustomButton: false,
      ),
      child: SlidingUpPanel(
        isDraggable: true,
        backdropEnabled: true,
        //minHeight: MediaQuery.of(context).size.height / 2 - 50,
        maxHeight: MediaQuery.of(context).size.height - 250,
        panel: const Center(
          child: Text("This is the sliding Widget"),
        ),
        collapsed: const Text('This is the collapsed panel'),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: TravalongColors.primary_30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                    SearchBar(), // todo: Lav komplet search widget som tager imod en query
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: (((constraints.maxWidth / 3) * 2) - 2) + 15,
                          child: _searchDateWidget(),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: ((constraints.maxWidth / 3) - 2) - 15,
                          child: _searchGenderWidget(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: _searchTextWidget(),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: _searchActionBtn(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchDateWidget() {
    final start = dateRange.start;
    final end = dateRange.end;
    //final travelDuration = dateRange.duration.inDays;

    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60,
        border: Border.all(color: TravalongColors.primary_30_stroke),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          DateButton(date: start, onPressed: selectDateRange, isStart: true),
          const SizedBox(width: 1), // space between start & end date
          DateButton(date: end, onPressed: selectDateRange),
        ],
      ),
    );
  }

  Future selectDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: TravalongColors.secondary_10,
                onPrimary: TravalongColors.primary_30,
                onSurface: TravalongColors.primary_text_bright,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: TravalongColors.primary_30,
                  backgroundColor:
                      TravalongColors.secondary_10, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (newDateRange == null) return; // pressed 'X'

    setState(() {
      dateRange = newDateRange; // pressed 'Saved'
    });
  }

  Widget _searchGenderWidget() {
    return InkWell(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: TravalongColors.secondary_10,
          border: Border.all(color: TravalongColors.primary_30_stroke),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonFormField<String>(
          alignment: AlignmentDirectional.center,
          borderRadius: BorderRadius.circular(10.0),
          dropdownColor: TravalongColors.secondary_10,
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.person_search_outlined,
              color: TravalongColors.primary_text_dark,
            ),
          ),
          iconSize: 0, // ! removes icon
          value: dropdownValue,
          //elevation: 16,

          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: ThemeText(
                textString: value,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                textColor: TravalongColors.primary_text_dark,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _searchTextWidget() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ThemeText(
            textString: "I'm searching for people ",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_bright,
          ),
          _textOptWidget(), // * dropdown
          const ThemeText(
            textString: ' the destination.',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_bright,
          ),
        ],
      ),
    );
  }

  Widget _textOptWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        // https://pub.dev/packages/dropdown_button2/example
        alignment: AlignmentDirectional.center,
        buttonHighlightColor: Colors.transparent,
        iconSize: 0,
        iconEnabledColor: Colors.transparent,
        iconDisabledColor: Colors.transparent,
        value: optvalue,
        dropdownElevation: 16,
        dropdownWidth: 100,
        dropdownDecoration: const BoxDecoration(
          color: TravalongColors.primary_30,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),

        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            optvalue = value!;
          });
        },
        items: optList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: ThemeText(
              textString: value,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              textColor: TravalongColors.secondary_10,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _searchActionBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: TravalongColors.secondary_10,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: TravalongColors.primary_30_stroke, // red as border color
          ),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: ThemeText(
            textString: 'Search for travelers',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_dark,
          ),
        ),
      ),
    );
  }
}
