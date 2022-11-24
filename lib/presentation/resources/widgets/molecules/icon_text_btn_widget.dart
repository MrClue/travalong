import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconTextButton extends StatelessWidget {
  final IconData faIcon;
  final String label;
  final String description;
  final Widget goToPage;

  const IconTextButton({
    Key? key,
    required this.faIcon,
    required this.label,
    required this.description,
    required this.goToPage,
  }) : /*assert(goToPage != null),*/
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goToPage),
        );
      }),
      child: Container(
        width: MediaQuery.of(context).size.width - 28,
        height: 65,
        //margin: const EdgeInsets.only(left: 14, right: 14),
        padding: const EdgeInsets.only(left: 7, right: 7),
        decoration: BoxDecoration(
          color: TravalongColors.primary_30,
          border: Border.all(
            color: TravalongColors.primary_30_stroke,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 35,
                  child: FaIcon(
                    faIcon,
                    size: 35,
                    color: TravalongColors.secondary_10,
                  ),
                ),
                //const SizedBox(width: 7),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: TravalongColors.secondary_text_dark),
                    ),
                  ],
                ),
              ],
            ),
            const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 24,
              color: TravalongColors.secondary_10,
            ),
          ],
        ),
      ),
    );
  }
}
