import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/generated/l10n.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';

import 'task_options_widget.dart';

class TaskDetailsHeaderWidget extends StatelessWidget {
  final TaskEntity task;
  const TaskDetailsHeaderWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    String? timeSpent;
    if (task.durationInMinute != null) {
      timeSpent = '';
      int hours = task.durationInMinute! ~/ 60;
      int minutes = task.durationInMinute! % 60;
      int seconds = (task.durationInMinute! * 60) % 60;
      if (hours > 0) timeSpent = S.current.hours(hours);
      if (minutes > 0) timeSpent = '$timeSpent ${S.current.minutes(minutes)}';
      if (seconds > 0) timeSpent = '$timeSpent ${S.current.seconds(seconds)}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpace,
        TaskOptionsWidget(task: task, isTaskDetails: true),
        30.verticalSpace,
        Text(task.content,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleLarge),
        10.verticalSpace,
        if ((task.description ?? '').trim().isNotEmpty) ...[
          Text(
            task.description ?? '',
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium,
          ),
          20.verticalSpace,
        ],
        if (task.createdAt != null) ...[
          Text(
            S.current.createdDate(
                DateFormat('d MMMM, y').format(task.createdAt!),
                DateFormat('hh:mm').format(task.createdAt!)),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          5.verticalSpace,
        ],
        if (task.dueDate?.datetime != null) ...[
          Text(
            S.current.dueDate_(
                DateFormat('d MMM, y').format(task.dueDate!.datetime!)),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          5.verticalSpace,
        ],
        if (timeSpent != null) ...[
          Text(
            S.current.timeSpentOnTask(timeSpent),
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          5.verticalSpace,
        ],
      ],
    );
  }
}
