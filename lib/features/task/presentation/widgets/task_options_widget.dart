import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/navigation/routes.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/core/values/enums/task_status.dart';
import 'package:smart_task/core/widgets/chip.dart';
import 'package:smart_task/core/widgets/icon_button.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/entities/tracker_widget.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/tasks_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

class TaskOptionsWidget extends StatelessWidget {
  final TaskEntity task;
  final bool isTaskDetails;
  const TaskOptionsWidget(
      {super.key, required this.task, required this.isTaskDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppChipWidget(
            color: null,
            hasDot: false,
            name: task.priority.name,
            textColor: task.priority.color,
            borderColor: task.priority.color),
        if (isTaskDetails) ...[
          6.horizontalSpace,
          AppChipWidget(
              color: null,
              hasDot: false,
              name: task.status.name,
              textColor: task.status.color,
              borderColor: task.status.color),
        ],
        6.horizontalSpace,
        TrackerWidget(task: task, showElapsedTime: isTaskDetails),
        Spacer(),
        PopupMenuButton<String>(
          elevation: 1,
          color: context.theme.scaffoldBackgroundColor,
          shadowColor: context.theme.colorScheme.primary,
          child: SmartTaskIconButtonWidget(
            width: 24.w,
            height: 24.w,
            svgPath: AppAssets.menu,
            buttonColor: Colors.transparent,
          ),
          itemBuilder: (_) => [
            PopupMenuItem<String>(
              height: 40.h,
              onTap: () => context
                  .push(NavigationRoutes.updateTask, extra: {'task': task}),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(S.current.edit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.headlineSmall),
            ),
            PopupMenuItem<String>(
              height: 40.h,
              onTap: () {
                serviceLocator<TasksBloc>().add(DeleteTaskEvent(task));
                context.pop();
              },
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(S.current.delete,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.headlineSmall),
            ),
            if (task.status == TaskStatusEnum.inProgress)
              PopupMenuItem<String>(
                height: 40.h,
                onTap: () {
                  if (serviceLocator<TaskTrackingBloc>()
                      .state
                      .tracker
                      .containsKey(task)) {
                    serviceLocator<TaskTrackingBloc>()
                        .add(StopTrackingEvent(task));
                  } else {
                    serviceLocator<TaskTrackingBloc>()
                        .add(StartTrackingEvent(task));
                  }
                },
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                    serviceLocator<TaskTrackingBloc>()
                            .state
                            .tracker
                            .containsKey(task)
                        ? S.current.stopTracking
                        : S.current.startTracking,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.theme.textTheme.headlineSmall),
              ),
          ],
        ),
      ],
    );
  }
}
