import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/asset_image.dart';
import 'package:taskati/core/function/dialogs/snackbar.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/presentation/views/home_view.dart';

String name = '';
String? path;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (path != null && name.isNotEmpty) {
                  ProjectLocalStorage.casheData('name', name);
                  ProjectLocalStorage.casheData('image', path);
                  ProjectLocalStorage.casheData('isUpload', true);

                  navigateWithReplacement(context, const HomeView());
                } else if (path == null && name.isNotEmpty) {
                  showErrorDialog(context, 'Please Add Your Image');
                } else if (path != null && name.isEmpty) {
                  showErrorDialog(context, 'Please Enter Your Name');
                } else {
                  showErrorDialog(context, 'Please Enter Your Name and Image');
                }
              },
              child: Text(
                'Done',
                style: getTitleStyle(),
              )),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: (path != null)
                      ? FileImage(File(path!)) as ImageProvider
                      : AssetImage(ProjectImages.user),
                ),
                const Gap(30),
                CustomButton(
                  onPressed: () {
                    uploadFromCamera();
                  },
                  text: 'Upload form Camera',
                ),
                const Gap(15),
                CustomButton(
                    onPressed: () {
                      uploadFromGallery();
                    },
                    text: 'Upload form Gallery'),
                const Gap(15),
                const Divider(),
                const Gap(15),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your Name'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  uploadFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }

  uploadFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}
