import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class IconTitleButton extends StatelessWidget {
  final IconData faIcon;
  final String label;
  final Widget goToPage;

  const IconTitleButton({
    Key? key,
    required this.faIcon,
    required this.label,
    required this.goToPage,
  }) : /*assert(goToPage != null),*/
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // ! ÆNDRE TIL AT ROUTE TIL RIGTIG SIDE
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goToPage),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 65,
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          color: TravalongColors.primary_text_dark,
          border: Border.all(
            color: TravalongColors.primary_30_stroke,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
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
