import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SearchStartScreen extends StatefulWidget {
  const SearchStartScreen({super.key});

  @override
  State<SearchStartScreen> createState() => _SearchStartScreenState();
}

const List<String> list = <String>['Male', 'Female', 'Any'];
const List<String> optList = <String>['currently in', 'going to'];

class _SearchStartScreenState extends State<SearchStartScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 05),
    end: DateTime(2022, 12, 24),
  );

  TextEditingController dateController = TextEditingController();
  String dropdownValue = list.first;
  String optvalue = optList.first;

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: ThemeTopBar(
        title: 'Search Travelers',
        enableCustomButton: false,
      ),
      child: SlidingUpPanel(
        isDraggable: true,
        backdropEnabled: true,
        minHeight: MediaQuery.of(context).size.height / 2 - 50,
        maxHeight: MediaQuery.of(context).size.height - 250,
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        collapsed: Text('This is the collapsed panel'),
        body: Container(
          width: double.infinity,
          color: TravalongColors.primary_30,
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SearchBar(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _searchDateWidget(),
                  const SizedBox(width: 4),
                  _searchGenderWidget(),
                ],
              ),
              const SizedBox(height: 25),
              _searchTextWidget(),
              const SizedBox(height: 75),
              _searchActionBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchDateWidget() {
    final start = dateRange.start;
    final end = dateRange.end;
    final difference = dateRange.duration;

    return Container(
      width: 257,
      height: 45,
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60,
        border: Border.all(color: TravalongColors.primary_30_stroke),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TravalongColors.secondary_10,
                textStyle: const TextStyle(fontSize: 12),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              onPressed: selectDateRange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(start)),
                      Text(DateFormat('EEEE').format(start)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TravalongColors.secondary_10,
                textStyle: const TextStyle(fontSize: 12),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ),
              onPressed: selectDateRange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(end)),
                      Text(DateFormat('EEEE').format(end)),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
        width: 106 + 12,
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
          hint: const ThemeText(
            textString: 'Gender',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            textColor: TravalongColors.primary_text_dark,
          ),
          iconEnabledColor: Colors.transparent,
          iconDisabledColor: Colors.transparent,
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: TravalongColors.primary_text_dark),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
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
          ThemeText(
            textString: 'Im looking for people',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_bright,
          ),
          _textOptWidget(),
          ThemeText(
            textString: ' the destination',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            textColor: TravalongColors.primary_text_bright,
          ),
        ],
      ),
    );
  }

  Widget _textOptWidget() {
    return SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          // https://pub.dev/packages/dropdown_button2/example
          alignment: AlignmentDirectional.center,
          buttonHighlightColor: Colors.transparent,
          hint: const ThemeText(
            textString: '- select option -',
            fontSize: 12,
            fontWeight: FontWeight.normal,
            textColor: TravalongColors.secondary_10,
          ),
          iconEnabledColor: Colors.transparent,
          iconDisabledColor: Colors.transparent,
          value: optvalue,
          dropdownElevation: 16,
          dropdownWidth: 104,
          dropdownDecoration: const BoxDecoration(
            color: TravalongColors.primary_30,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          style: const TextStyle(
            color: TravalongColors.secondary_10,
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
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _searchActionBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        width: 367 + 12,
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
            textString: 'Search',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            textColor: TravalongColors.primary_text_dark,
          ),
        ),
      ),
    );
  }
}
