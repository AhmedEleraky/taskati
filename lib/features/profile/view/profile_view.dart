import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/constants/asset_image.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('user');
    var darkMode = box.get('darkMode', defaultValue: false);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ProjectColors.primary,
        actions: [
          IconButton(
            icon: Icon(darkMode ? Icons.sunny : Icons.dark_mode),
            color: ProjectColors.primary,
            onPressed: () {
              setState(() {
                box.put('darkMode', !darkMode);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
            valueListenable: Hive.box('user').listenable(),
            builder: (context, box, child) {
              String path = box.get('image') ?? '';
              String name = box.get('name') ?? '';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: path.isNotEmpty
                          ? FileImage(File(path)) as ImageProvider
                          : AssetImage(ProjectImages.user),
                      child: IconButton(
                        onPressed: () {},
                        icon: Container(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: darkMode
                                ? ProjectColors.black
                                : ProjectColors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt_rounded),
                              color: ProjectColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Divider(
                    color: ProjectColors.primary,
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      Text(
                        name.isNotEmpty ? name : '',
                        style: getTitleStyle(),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 21,
                        backgroundColor: ProjectColors.primary,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: darkMode
                              ? ProjectColors.black
                              : ProjectColors.white,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const Column(
                                    children: [],
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit_rounded),
                            color: ProjectColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
