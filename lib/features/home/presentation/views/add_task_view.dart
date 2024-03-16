import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var date = DateFormat.yMd().format(DateTime.now());
  var startTime = DateFormat('hh:mm: a').format(DateTime.now());
  var endTime = DateFormat('hh:mm: a')
      .format(DateTime.now().add(const Duration(minutes: 30)));
  int color = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: ProjectColors.primary,
        ),
        title: Text('Add Task', style: getTitleStyle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: getTitleStyle(color: ProjectColors.black),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter title here'),
              ),
              const Gap(10),
              Text(
                'Note',
                style: getTitleStyle(color: ProjectColors.black),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter note here'),
              ),
              const Gap(10),
              Text(
                'Date',
                style: getTitleStyle(color: ProjectColors.black),
              ),
              TextFormField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        date = DateFormat.yMd().format(value);
                      });
                    } else {}
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    hintText: date),
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Start Time',
                      style: getTitleStyle(color: ProjectColors.black),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'End Time',
                      style: getTitleStyle(color: ProjectColors.black),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              startTime = value.format(context);
                            });
                          } else {}
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.watch_later_outlined),
                          hintText: startTime),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              endTime = value.format(context);
                            });
                          } else {}
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.watch_later_outlined),
                          hintText: endTime),
                    ),
                  ),
                ],
              ),
              const Gap(50),
              Row(
                children: [
                  Row(
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(3),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    color = index;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: index == 0
                                      ? ProjectColors.red
                                      : index == 1
                                          ? ProjectColors.orange
                                          : ProjectColors.primary,
                                  child: index == color
                                      ? Icon(Icons.check,
                                          color: ProjectColors.white)
                                      : const SizedBox(),
                                ),
                              ),
                            )),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Create Task',
                    onPressed: () {},
                    width: 150,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
