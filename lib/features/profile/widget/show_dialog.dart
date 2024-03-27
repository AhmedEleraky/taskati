import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/profile/view/profile_view.dart';

Future<dynamic> showTextDialog(BuildContext context, String name) {
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController(text: name);
  final box = Hive.box('user');
  name = ProjectLocalStorage.getCashedData('name');
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(),
          height: 200,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Enter your name'),
                        controller: textController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(15),
                      CustomButton(
                          width: double.infinity,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ProjectLocalStorage.casheData(
                                  'name', textController.text); 

                              Navigator.of(context).pop();
                              navigateWithReplacement(
                                  context, const ProfileView());
                            }
                          },
                          text: 'Update your name'),
                    ]),
              ),
            ),
          ),
        ),
      );
    },
  );
}
