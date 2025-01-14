import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/widgets/task_comments.dart';
import 'package:smart_task/features/task/presentation/widgets/task_details_header.dart';
import 'package:smart_task/generated/l10n.dart';

import '../widgets/create_comment.dart';

class TaskDetailsWidget extends StatelessWidget {
  final TaskEntity task;
  final ScrollController scrollController;
  const TaskDetailsWidget(
      {super.key, required this.task, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 48.w,
            height: 5.h,
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
                color: context.theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(100.r)),
          ),
        ),
        12.verticalSpace,
        Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            label: Text(
              S.current.addComment,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge
                  ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500),
            ),
            onPressed: () => showCreateCommentWidget(context, task),
            icon:
                SvgPicture.asset(AppAssets.comment, width: 16.w, height: 16.w),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskDetailsHeaderWidget(task: task),
                40.verticalSpace,
                TaskCommentsWidget(task: task)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
