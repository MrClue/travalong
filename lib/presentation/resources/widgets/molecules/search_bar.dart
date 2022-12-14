import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class SearchBar {
  // search bar widget
  //
  // Default values:
  //double height = 30.0;

  static Widget staticSearchBar() {
    TextEditingController textEditController = TextEditingController();
    return TextField(
      controller: textEditController,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Search ',
        hintText: "Type something",
        fillColor: TravalongColors.primary_30,
        prefixIcon: const Icon(
          Icons.search,
          color: TravalongColors.secondary_10,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: TravalongColors.primary_30_stroke, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
              color: TravalongColors.primary_30_stroke, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: TravalongColors.secondary_10, width: 1.5),
        ),
      ),
      //onChanged: onChanged,
    );
  }

  static Widget searchBar({
    controller,
    double height = 30.0,
    String hintText = "hintText",
    String text = "",
    onChanged,
  }) {
    return Column(
      children: [
        SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide:
                    const BorderSide(color: TravalongColors.primary_30_stroke),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide:
                    const BorderSide(color: TravalongColors.primary_30_stroke),
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: TravalongColors.secondary_text_bright,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
              labelText: text,
              prefixIcon: Container(
                padding: const EdgeInsets.all(4),
                width: 16,
                child: const Icon(
                  Icons.search_outlined,
                  color: TravalongColors.secondary_10,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
