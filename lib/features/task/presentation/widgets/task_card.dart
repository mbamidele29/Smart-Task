import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_task/core/utils/extensions/num_ext.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/widgets/show_task_details.dart';
import 'package:smart_task/features/task/presentation/widgets/task_options_widget.dart';
import 'package:smart_task/generated/l10n.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEntity task;
  const TaskCardWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => showTaskDetailsBottomSheet(context, task),
      child: Card(
        child: Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskOptionsWidget(task: task, isTaskDetails: false),
              12.verticalSpace,
              Text(task.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontSize: 13.sp)),
              if ((task.description ?? '').trim().isNotEmpty) ...[
                8.verticalSpace,
                Text(
                  task.description ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.titleMedium,
                ),
              ],
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconWidget(
                      name: task.dueDate?.formattedDate ?? S.current.notSet,
                      svgPath: AppAssets.clock),
                  if (task.durationInMinute != null)
                    Text(
                        S.current.timeSpentOnTask(task.durationInMinute
                                ?.formattedFromMinuteTimeNoPadding ??
                            ''),
                        style: context.theme.textTheme.titleSmall),
                  // _IconWidget(
                  //     name: '${task.commentCount ?? 0}',
                  //     svgPath: AppAssets.comment)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconWidget extends StatelessWidget {
  final String name;
  final String svgPath;
  const _IconWidget({required this.name, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svgPath, width: 10.w, height: 10.w),
        4.horizontalSpace,
        Text(name, style: context.theme.textTheme.titleSmall),
      ],
    );
  }
}
