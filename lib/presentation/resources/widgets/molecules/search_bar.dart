import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/screens/chat/chat_search_results.dart';

class SearchBar extends StatefulWidget {
  final String? hintText;
  Function()? onTapped;

  SearchBar({
    this.hintText,
    this.onTapped,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    bool open = false;
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 46,
            height: 30,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    onTap: (() {
                      SearchBar().onTapped;
                    }),
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: TravalongColors.primary_30_stroke),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: TravalongColors.primary_30_stroke),
                      ),
                      hintText: SearchBar().hintText,
                      hintStyle: GoogleFonts.poppins(
                        color: TravalongColors.secondary_text_bright,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2,
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(4),
                        width: 16,
                        child: const Icon(
                          Icons.search_outlined,
                          color: TravalongColors.secondary_10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
