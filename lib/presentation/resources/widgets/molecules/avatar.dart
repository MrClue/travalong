//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.url,
    required this.radius,
  }) : super(key: key);

  const Avatar.small({
    Key? key,
    required this.url,
  })  : radius = 12,
        super(key: key);

  const Avatar.medium({
    Key? key,
    required this.url,
  })  : radius = 25,
        super(key: key);

  const Avatar.large({
    Key? key,
    required this.url,
  })  : radius = 35,
        super(key: key);

  final double radius;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      //backgroundImage: CachedNetworkImageProvider(url),
      backgroundColor: TravalongColors.placeholder_text,
    );
  }
}