import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

showErrorDialog(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: ProjectColors.red, content: Text(text)));
}
