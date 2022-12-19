import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/travalong_navbar.dart';
import 'package:intl/intl.dart';

class SearchStartScreen extends StatefulWidget {
  const SearchStartScreen({super.key});

  @override
  State<SearchStartScreen> createState() => _SearchStartScreenState();
}

const List<String> list = <String>['Male', 'Female', 'Any'];

class _SearchStartScreenState extends State<SearchStartScreen> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 11, 05),
    end: DateTime(2022, 12, 24),
  );

  TextEditingController dateController = TextEditingController();
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: ThemeTopBar(
        title: 'Search Travelers',
        enableCustomButton: false,
      ),
      child: Container(
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
                SizedBox(width: 4),
                _searchGenderWidget(),
              ],
            )
          ],
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(TravalongColors.secondary_10),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 12)),
              ),
              onPressed: selectDateRange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month_outlined),
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
          SizedBox(width: 1),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(TravalongColors.secondary_10),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 12)),
              ),
              onPressed: selectDateRange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month_outlined),
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
        ],
      ),
    );
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

  Future selectDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; // pressed 'X'

    setState(() {
      dateRange = newDateRange; // pressed 'Saved'
    });
  }
}
