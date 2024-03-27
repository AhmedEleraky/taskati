import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/asset_image.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/presentation/views/home_view.dart';
import 'package:taskati/features/profile/widget/show_dialog.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
    final box = Hive.box('user');
    var darkMode = box.get('darkMode') ?? false;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ProjectColors.primary,
        leading: IconButton(
            onPressed: () {
              setState(() {});
              navigateTo(context, const HomeView());
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            icon: Icon(
              darkMode ? Icons.sunny : Icons.dark_mode_rounded,
            ),
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
              return Container(
                decoration: const BoxDecoration(shape: BoxShape.rectangle),
                child: Column(
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40))),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: const BoxDecoration(),
                                        height: 200,
                                        width: double.infinity,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomButton(
                                                    width: double.infinity,
                                                    onPressed: () {
                                                      uploadFromCamera();
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    text: 'Upload form Camera',
                                                  ),
                                                  const Gap(15),
                                                  CustomButton(
                                                      width: double.infinity,
                                                      onPressed: () {
                                                        uploadFromGallery();
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      text:
                                                          'Upload form Gallery'),
                                                ]),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
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
                          ProjectLocalStorage.getCashedData('name'),
                          style: getTitleStyle(context,
                              color: ProjectColors.primary),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 21,
                          backgroundColor: ProjectColors.primary,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            child: IconButton(
                              onPressed: () {
                                showTextDialog(context, name);
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit_rounded),
                              color: ProjectColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  uploadFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      ProjectLocalStorage.casheData('image', pickedImage.path);
      setState(() {
        path = pickedImage.path;
      });
    }
  }

  uploadFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      ProjectLocalStorage.casheData('image', pickedImage.path);
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}
