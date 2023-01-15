import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_text.dart';

import '../../../resources/colors.dart';

class DateButton extends StatelessWidget {
  final DateTime date;
  final Future Function() onPressed;
  final bool isStart;

  const DateButton({
    Key? key,
    required this.date,
    required this.onPressed,
    this.isStart = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: TravalongColors.secondary_10,
            border: Border.all(color: TravalongColors.primary_30_stroke),
            borderRadius: BorderRadius.only(
              topLeft: isStart ? const Radius.circular(10) : Radius.zero,
              topRight: isStart ? Radius.zero : const Radius.circular(10),
              bottomLeft: isStart ? const Radius.circular(10) : Radius.zero,
              bottomRight: isStart ? Radius.zero : const Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // spaceAround
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThemeText(
                    textString: DateFormat('dd MMM yyyy').format(date),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: TravalongColors.primary_text_dark,
                  ),
                  ThemeText(
                    textString: DateFormat('EEEE').format(date),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    textColor: TravalongColors.primary_text_dark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: TravalongColors.secondary_10,
        textStyle: const TextStyle(fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: isStart ? const Radius.circular(10) : Radius.zero,
            topRight: isStart ? Radius.zero : const Radius.circular(10),
            bottomLeft: isStart ? const Radius.circular(10) : Radius.zero,
            bottomRight: isStart ? Radius.zero : const Radius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.calendar_month_outlined),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ThemeText(
                textString: DateFormat('dd MMM yyyy').format(date),
                fontSize: 13, // ! overflow at 14
                fontWeight: FontWeight.bold,
                textColor: TravalongColors.primary_text_dark,
              ),
              ThemeText(
                textString: DateFormat('EEEE').format(date),
                fontSize: 12,
                fontWeight: FontWeight.normal,
                textColor: TravalongColors.primary_text_dark,
              ),
            ],
          ),
        ],
      ),
    );
  }
  */
}
