import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import 'date_button.dart';

class CalenderWidget extends StatefulWidget {
  final DateTime startDate; // dateRange.start;
  final DateTime endDate; // dateRange.end;
  final Function selectDateRange;
  //final travelDuration = dateRange.duration.inDays;
  const CalenderWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.selectDateRange,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60,
        border: Border.all(color: TravalongColors.primary_30_stroke),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          DateButton(
              date: widget.startDate,
              onPressed: widget.selectDateRange(),
              isStart: true),
          const SizedBox(width: 1), // space between start & end date
          DateButton(date: widget.endDate, onPressed: widget.selectDateRange()),
        ],
      ),
    );
  }
}
