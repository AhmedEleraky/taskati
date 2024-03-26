import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/data/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.model,
  });
  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: model.color == 0
            ? ProjectColors.primary
            : model.color == 1
                ? ProjectColors.orange
                : model.color == 1
                    ? ProjectColors.red
                    : ProjectColors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: getTitleStyle(
                    context,  color: ProjectColors.white, fontWeight: FontWeight.bold),
                ),
                const Gap(5),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: ProjectColors.white,
                    ),
                    const Gap(15),
                    Text(
                      '${model.startTime} : ${model.endTime}',
                      style: getSmallStyle(color: ProjectColors.white),
                    ),
                  ],
                ),
                const Gap(5),
                Text(
                  model.note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getbodyStyle(context, color: ProjectColors.white),
                )
              ],
            ),
          ),
          Container(
            color: ProjectColors.white,
            height: 80,
            width: .5,
          ),
          const Gap(5),
          RotatedBox(
              quarterTurns: 3,
              child: Text(
                model.isComplete ? 'Completed' : 'To Do',
                style: getbodyStyle(context, color: ProjectColors.white),
              )),
        ],
      ),
    );
  }
}
