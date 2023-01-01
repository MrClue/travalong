import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/icon_text_btn_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/profile_widget.dart';
import 'package:travalong/presentation/screens/profile/my_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // https://www.youtube.com/watch?v=CX9_op-OW8g&list=PLCAZyR6zw2pyyjdifS_AFJf6HA4Ud8R4_&index=9

    return SafeScaffold(
      //navbar: NavBar(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 30,
                  ),
                  IconTextButton(
                    faIcon: FontAwesomeIcons.solidUser,
                    label: "My Profile",
                    description: "Update your profile information here.",
                    goToPage: MyProfilePage(),
                  ),
                  SizedBox(height: 14),
                  MediaWidget(), // todo: not done
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaWidget extends StatelessWidget {
  const MediaWidget({
    Key? key,
  }) : super(key: key);

  static const List<String> sampleImages = [
    "https://images.unsplash.com/photo-1669178197999-32178a532277?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80",
    "https://images.unsplash.com/photo-1669072596436-15df4a8c083d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
    "https://images.unsplash.com/photo-1665700301643-def92acad454?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const ThemeTextH2(
          textString: "Shared Media",
          textColor: TravalongColors.primary_text_bright,
        ),
        const ThemeText(
          textString: "What others see, when visiting your profile.",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          textColor: TravalongColors.secondary_text_bright,
        ),
        FanCarouselImageSlider(
          imagesLink: sampleImages,
          isAssets: false,
          autoPlay: false,
          sliderHeight: MediaQuery.of(context).size.height * 0.33,
          imageRadius: 10,
          indicatorActiveColor: TravalongColors.secondary_10,
          imageFitMode: BoxFit.cover,
        ),
      ],
    );
  }
}
