import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/pages/task_details.dart';

showTaskDetailsBottomSheet(BuildContext context, TaskEntity task) =>
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => DraggableScrollableSheet(
        minChildSize: .5,
        maxChildSize: .8,
        initialChildSize: .8,
        expand: false,
        builder: (context, scrollController) =>
            TaskDetailsWidget(task: task, scrollController: scrollController),
      ),
    );
