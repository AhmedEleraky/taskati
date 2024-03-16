import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/home/presentation/views/add_task_view.dart';
import 'package:taskati/features/home/presentation/widgets/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const HomeHeader(),
              const Gap(30),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Today',
                        style: getTitleStyle(color: ProjectColors.black),
                      ),
                      Text(
                        DateFormat.yMEd().format(DateTime.now()),
                        style: getTitleStyle(color: ProjectColors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    text: '+ Add Task',
                    onPressed: () {
                      navigateTo(context, const AddTaskView());
                    },
                    width: 150,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
