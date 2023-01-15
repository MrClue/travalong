import 'package:flutter/material.dart';

import '../../colors.dart';
import '../theme/theme_text.dart';

class ConfirmButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function onSave;
  final bool valuesChanged;

  const ConfirmButton({
    Key? key,
    required this.formKey,
    required this.onSave,
    required this.valuesChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = valuesChanged
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
