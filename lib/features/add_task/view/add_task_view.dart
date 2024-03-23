import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/data/task_model.dart';
import 'package:taskati/features/home/presentation/views/home_view.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.model});
  final TaskModel? model;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var date = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String? startTime = DateFormat('hh:mm: a').format(DateTime.now());
  var endTime = DateFormat('hh:mm: a')
      .format(DateTime.now().add(const Duration(minutes: 30)));
  int color = 0;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.model?.title);
    noteController = TextEditingController(text: widget.model?.note);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('user');
    var darkMode = box.get('darkMode');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ProjectColors.primary,
        centerTitle: true,
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
                style: getTitleStyle(
                    color:
                        darkMode ? ProjectColors.white : ProjectColors.primary),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title here',
                  hintStyle: TextStyle(
                      color:
                          darkMode ? ProjectColors.white : ProjectColors.black),
                ),
              ),
              const Gap(10),
              Text(
                'Note',
                style: getTitleStyle(
                    color:
                        darkMode ? ProjectColors.white : ProjectColors.primary),
              ),
              TextFormField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter note here',
                  hintStyle: TextStyle(
                      color:
                          darkMode ? ProjectColors.white : ProjectColors.black),
                ),
              ),
              const Gap(10),
              Text(
                'Date',
                style: getTitleStyle(
                    color:
                        darkMode ? ProjectColors.white : ProjectColors.primary),
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        date = widget.model != null
                            ? widget.model!.date
                            : DateFormat('dd/MM/yyyy').format(value);
                      });
                    } else {}
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  hintText: date,
                  hintStyle: TextStyle(
                      color:
                          darkMode ? ProjectColors.white : ProjectColors.black),
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Start Time',
                      style: getTitleStyle(
                          color: darkMode
                              ? ProjectColors.white
                              : ProjectColors.primary),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'End Time',
                      style: getTitleStyle(
                          color: darkMode
                              ? ProjectColors.white
                              : ProjectColors.primary),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
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
                        hintText: startTime,
                        hintStyle: TextStyle(
                            color: darkMode
                                ? ProjectColors.white
                                : ProjectColors.black),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
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
                        hintText: endTime,
                        hintStyle: TextStyle(
                            color: darkMode
                                ? ProjectColors.white
                                : ProjectColors.black),
                      ),
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
                    onPressed: () {
                      String id = '${titleController.text}${DateTime.now()}';
                      ProjectLocalStorage.casheTask(
                          id,
                          TaskModel(
                              id: id,
                              title: titleController.text,
                              note: noteController.text,
                              date: date,
                              startTime: startTime!,
                              endTime: endTime,
                              isComplete: false,
                              color: color));
                      navigateWithReplacement(context, const HomeView());
                    },
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
