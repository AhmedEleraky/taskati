import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/core/widgets/custom_button.dart';
import 'package:taskati/features/add_task/view/add_task_view.dart';
import 'package:taskati/features/data/task_model.dart';
import 'package:taskati/features/home/presentation/widgets/home_header.dart';
import 'package:taskati/features/home/presentation/widgets/task_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedValue = DateFormat('dd/MM/yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('user');
    var darkMode = box.get('darkMode');
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
                        style: getTitleStyle(
                            color: darkMode
                                ? ProjectColors.white
                                : ProjectColors.black),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        style: getTitleStyle(
                            color: darkMode
                                ? ProjectColors.white
                                : ProjectColors.black),
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
              const Gap(15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DatePicker(
                    DateTime.now().add(const Duration(days: -2)),
                    height: 100,
                    width: 80,
                    dateTextStyle: TextStyle(
                        color: darkMode
                            ? ProjectColors.white
                            : ProjectColors.black),
                    dayTextStyle: TextStyle(
                        color: darkMode
                            ? ProjectColors.white
                            : ProjectColors.black),
                    monthTextStyle: TextStyle(
                        color: darkMode
                            ? ProjectColors.white
                            : ProjectColors.black),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: ProjectColors.primary,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setState(() {
                        _selectedValue = DateFormat('dd/MM/yyyy').format(date);
                      });
                    },
                  ),
                ],
              ),
              const Gap(15),
              Expanded(
                child: ValueListenableBuilder<Box<TaskModel>>(
                  valueListenable: Hive.box<TaskModel>('task').listenable(),
                  builder: (context, Box<TaskModel> box, child) {
                    List<TaskModel> tasks = [];
                    for (var element in box.values) {
                      if (element.date == _selectedValue) {
                        tasks.add(element);
                      }
                    }
                    if (tasks.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('asset/emptyblue.json'),
                            Text(
                              'No Tasks Today!',
                              style: getTitleStyle(),
                            )
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                padding: const EdgeInsets.all(10),
                                color: ProjectColors.green,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: ProjectColors.white,
                                    ),
                                    const Gap(5),
                                    Text(
                                      'Completed',
                                      style: getbodyStyle(
                                          color: ProjectColors.white),
                                    ),
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                padding: const EdgeInsets.all(10),
                                color: ProjectColors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: ProjectColors.white,
                                    ),
                                    const Gap(5),
                                    Text(
                                      'Deleted',
                                      style: getbodyStyle(
                                          color: ProjectColors.white),
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  box.put(
                                      tasks[index].id,
                                      TaskModel(
                                          id: tasks[index].id,
                                          title: tasks[index].title,
                                          note: tasks[index].note,
                                          date: tasks[index].date,
                                          startTime: tasks[index].startTime,
                                          endTime: tasks[index].endTime,
                                          isComplete: true,
                                          color: 3));
                                } else {
                                  box.delete(tasks[index].id);
                                }
                              },
                              child: TaskItem(model: tasks[index])),
                          onTap: () {
                            navigateTo(context, const AddTaskView());
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
