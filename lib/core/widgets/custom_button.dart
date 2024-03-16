import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });
  final String text;
  final Function() onPressed;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ProjectColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onPressed,
          child: Text(
            text,
            style: getSmallStyle(color: ProjectColors.white),
          )),
    );
  }
}
