import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:travalong/presentation/resources/widgets/theme/safe_scaffold.dart';
import 'package:travalong/presentation/screens/search/widgets/background.dart';
import 'package:travalong/presentation/screens/search/widgets/date_button.dart';

import '../../resources/colors.dart';
import '../../resources/widgets/theme/theme_text.dart';
import '../../resources/widgets/navigation/search_bar.dart';
import '../../resources/widgets/navigation/theme_topbar.dart';

final List<String> genderType = <String>['Any', 'Male', 'Female'];
final List<String> searchType = <String>['currently in', 'going to'];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController listViewController = ScrollController();

  // * travel start & end dates
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(), // Todays date
    end: DateTime.now().add(const Duration(days: 1)), // Tomorrows date
  );
  //final travelDuration = dateRange.duration.inDays;
  TextEditingController dateController = TextEditingController();

  // * dropdown values
  String selectedGender = genderType.first;
  String selectedSearchType = searchType.first;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: const ThemeTopBar(
        title: 'Search Travelers',
        enableCustomButton: false,
      ),
      child: SnappingSheet(
        lockOverflowDrag: true,
        snappingPositions: const [
          SnappingPosition.factor(
            positionFactor: 1.0, // ! 1.0 = helt i top
            snappingCurve: Curves.easeInOutBack,
            snappingDuration: Duration(seconds: 1),
            grabbingContentOffset: GrabbingContentOffset.bottom,
          ),
          SnappingPosition.factor(
            snappingCurve: Curves.elasticOut,
            snappingDuration: Duration(milliseconds: 1750),
            positionFactor: 0.45,
          ),
        ],
        grabbing: const GrabbingWidget(),
        grabbingHeight: 50,
        sheetAbove: SnappingSheetContent(
          draggable: true,
          childScrollController: listViewController,
          child: Container(
            color: TravalongColors.primary_30, // ! background color
            child: ListView(
              physics: const NeverScrollableScrollPhysics(), // disable scroll
              controller: listViewController,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Column(
                        children: [
                          SearchBar.staticSearchBar(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: ((constraints.maxWidth / 3) * 2) - 1,
                                child: _searchDateWidget(),
                              ),
                              SizedBox(
                                width: (constraints.maxWidth / 3) - 1,
                                child: _searchGenderWidget(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: constraints.maxWidth,
                            child: _searchTextWidget(),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: constraints.maxWidth,
                            child: _searchActionBtn(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        sheetBelow: null,
        child: Background(
          startDate: dateRange.start,
          endDate: dateRange.end,
          genderType: selectedGender,
          searchType: selectedSearchType,
        ), // search results page
      ),
    );
  }

  // * WIDGETS TIL UI
  Widget _searchDateWidget() {
    return Row(
      children: [
        DateButton(
            date: dateRange.start, onPressed: selectDateRange, isStart: true),
        const SizedBox(width: 1), // space between start & end date
        DateButton(date: dateRange.end, onPressed: selectDateRange),
      ],
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
          dropdownColor: TravalongColors.secondary_10, // should be white
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
          value: selectedGender,
          //elevation: 16,

          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              selectedGender = value!;
            });
          },
          items: genderType.map<DropdownMenuItem<String>>((String value) {
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
            fontSize: 13,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_bright,
          ),
          _textOptWidget(), // * dropdown
          const ThemeText(
            textString: ' the destination.',
            fontSize: 13,
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
        iconSize: 0, // ! removes icon
        value: selectedSearchType,
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
            selectedSearchType = value!;
          });
        },
        items: searchType.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: ThemeText(
              textString: value,
              fontWeight: FontWeight.bold,
              fontSize: 13,
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

// ! This is the widget you can grab to expand the sheet
class GrabbingWidget extends StatelessWidget {
  const GrabbingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60, //Colors.white,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(20)), // ! top
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // * small top line
          Container(
            color: TravalongColors.primary_30_stroke, //Colors.grey[200],
            height: 2,
            margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          ),
          // * blue grabbing widget line
          Container(
            margin: const EdgeInsets.only(bottom: 15), // ! top 20
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: TravalongColors.secondary_10,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
