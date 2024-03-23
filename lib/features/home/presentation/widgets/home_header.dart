import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/asset_image.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/profile/view/profile_view.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? path;
  String name = '';

  @override
  void initState() {
    super.initState();

    name = ProjectLocalStorage.getCashedData('name');
    path = ProjectLocalStorage.getCashedData('image');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${name.isEmpty ? '' : name}',
              style: getTitleStyle(),
            ),
            Text(
              'Have a Nice Day!',
              style: getbodyStyle(
                  color: darkMode ? ProjectColors.white : ProjectColors.black),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            navigateTo(context, const ProfileView());
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: path != null
                ? FileImage(File(path!)) as ImageProvider
                : AssetImage(ProjectImages.user),
          ),
        ),
      ],
    );
  }
}
