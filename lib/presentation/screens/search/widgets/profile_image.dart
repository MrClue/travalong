import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';

import '../../../resources/colors.dart';
import '../../../resources/widgets/atoms/theme_text.dart';

class ProfileImagePreview extends StatefulWidget {
  final String image;
  final int sharedInterests;
  final double height;
  final dynamic onTapped;
  final bool hasButton;

  const ProfileImagePreview({
    super.key,
    required this.image,
    required this.sharedInterests,
    this.height = 200,
    this.hasButton = false,
    this.onTapped,
  });

  @override
  State<ProfileImagePreview> createState() => _ProfileImagePreviewState();
}

class _ProfileImagePreviewState extends State<ProfileImagePreview> {
  FirebaseController fController = FirebaseController();
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // * image
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            widget.image,
            height: widget.height,
            fit: BoxFit.cover,
          ),
        ),
        // * shared interests & shared connections
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: widget.hasButton == true ? 40 : 30,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: widget.hasButton == true
                      ? const EdgeInsets.symmetric(horizontal: 10.0)
                      : EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: widget.hasButton == true
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      ThemeText(
                        textString:
                            '${widget.sharedInterests} shared interests',
                        fontSize: widget.hasButton == true ? 16 : 14,
                        textColor: TravalongColors.primary_text_dark,
                        fontWeight: FontWeight.w600,
                      ),
                      if (widget.hasButton == true)
                        InkWell(
                          onTap: (() {
                            // todo: check if user is already connected and set isConnected to true
                            setState(() {
                              isConnected = true;
                            });

                            widget.onTapped();
                          }),
                          child: Icon(
                            isConnected == false
                                ? Icons.person_add_rounded
                                : Icons.person_rounded,
                            color: isConnected == false
                                ? TravalongColors.primary_text_dark
                                : TravalongColors.secondary_10,
                            size: 40,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
