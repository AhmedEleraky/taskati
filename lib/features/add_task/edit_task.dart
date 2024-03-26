import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/data/task_model.dart';
import 'package:taskati/features/home/presentation/views/home_view.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key, required this.model});

  final TaskModel model;
  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var date;
  String? startTime;
  var endTime;
  int color = 0;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.model.title);
    noteController = TextEditingController(text: widget.model.note);
    date = widget.model.date;
    startTime = widget.model.startTime;
    endTime = widget.model.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ProjectColors.primary,
        centerTitle: true,
        title: Text('Edit Task', style: getTitleStyle(context)),
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
                  context,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title here',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const Gap(10),
              Text(
                'Note',
                style: getTitleStyle(
                  context,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextFormField(
                controller: noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter note here',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const Gap(10),
              Text(
                'Date',
                style: getTitleStyle(
                  context,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData(
                              colorScheme: ColorScheme.fromSeed(
                                  primary: theme.primary,
                                  seedColor: theme.primary)),
                          child: child!);
                    },
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        date = widget.model != null
                            ? widget.model.date
                            : DateFormat('dd/MM/yyyy').format(value);
                      });
                    } else {}
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  hintText: date,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Start Time',
                      style: getTitleStyle(
                        context,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Text(
                      'End Time',
                      style: getTitleStyle(
                        context,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
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
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData(
                                    colorScheme: ColorScheme.fromSeed(
                                        primary: theme.primary,
                                        seedColor: theme.primary)),
                                child: child!);
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              startTime = value.format(context);
                            });
                          } else {}
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.watch_later_outlined,
                            color: Theme.of(context).colorScheme.primary),
                        hintText: startTime,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
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
                          builder: (context, child) {
                            return Theme(
                                data: ThemeData(
                                    colorScheme: ColorScheme.fromSeed(
                                        primary: theme.primary,
                                        seedColor: theme.primary)),
                                child: child!);
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              endTime = value.format(context);
                            });
                          } else {}
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.watch_later_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintText: endTime,
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
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
                    text: 'Save Task',
                    onPressed: () {
                      ProjectLocalStorage.casheTask(
                          widget.model.id,
                          TaskModel(
                              id: widget.model.id,
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
