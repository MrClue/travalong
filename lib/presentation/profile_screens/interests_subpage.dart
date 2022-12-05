import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class InterestsSubpage extends StatelessWidget {
  const InterestsSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const ThemeTopBar(
        backArrow: BackArrow(),
        title: "Interests & Hobbies",
        enableCustomButton: false,
        customButtonWidget: Text(""),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 50, 40, 50),
        child: Column(
          children: [
            Container(
              color: Colors.black12,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text:
                            'Please select what interests and hobbies suits you the best. '),
                    TextSpan(
                        text:
                            'This will help you find others with common interests.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            InterestsWidget(),
          ],
        ),
      ),
    );
  }
}

// ! selection items code
class Interest {
  final int id;
  final String name;

  Interest({required this.id, required this.name});
}

class InterestsWidget extends StatefulWidget {
  const InterestsWidget({super.key});

  @override
  State<InterestsWidget> createState() => _InterestsWidgetState();
}

class _InterestsWidgetState extends State<InterestsWidget> {
  static final List<Interest> _interests = [
    Interest(id: 1, name: "Interest1"),
    Interest(id: 2, name: "Interest2"),
    Interest(id: 3, name: "Interest3"),
    Interest(id: 4, name: "Interest4"),
    Interest(id: 5, name: "Interest5"),
    Interest(id: 6, name: "Interest6"),
    Interest(id: 7, name: "Interest7"),
    Interest(id: 8, name: "Interest8"),
  ];
  final _items = _interests
      .map((interest) => MultiSelectItem<Interest>(interest, interest.name))
      .toList();

  List<Interest> _selectedInterests = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedInterests = _interests;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.4),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    searchable: true,
                    buttonText: const Text("Your Interests"),
                    title: const Text("Interests"),
                    items: _items,
                    onConfirm: (values) {
                      List<Interest> bufferSelectedInterest = [];
                      var newValues = values as List<MultiSelectItem<Interest>>;
                      newValues.forEach((element) {
                        bufferSelectedInterest.add(element.value);
                      });
                      _selectedInterests = bufferSelectedInterest;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _selectedInterests.remove(value);
                        });
                      },
                    ),
                  ),
                  _selectedInterests.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "None selected",
                            style: TextStyle(color: Colors.black54),
                          ))
                      : Container(),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
