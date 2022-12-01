import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// * this function can be called at a specific time,
// * (ex. when clicking a button) to dismiss the keyboard

/// Hides the onscreen keyboard
void hideKeyboard(BuildContext context) {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  FocusScope.of(context).requestFocus(FocusNode());
}
