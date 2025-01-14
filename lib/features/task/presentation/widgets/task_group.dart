import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/values/enums/task_status.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/bloc/tasks_bloc.dart';
import 'package:smart_task/features/task/presentation/widgets/task_card_shimmer.dart';

import 'task_card.dart';
import 'task_group_header_delegate.dart';

class TaskGroupWidget extends StatelessWidget {
  final List<TaskEntity>? tasks;
  final TaskStatusEnum taskStatus;
  final ScrollController parentScrollController;

  const TaskGroupWidget(
      {super.key,
      required this.tasks,
      required this.taskStatus,
      required this.parentScrollController});

  @override
  Widget build(BuildContext context) {
    bool isDragging = false;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 335.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: context.theme.colorScheme.secondary),
        child: DragTarget<TaskEntity>(
          onAcceptWithDetails: (details) {
            serviceLocator<TasksBloc>().add(UpdateTaskStatusEvent(
                task: details.data, newStatus: taskStatus));
          },
          onWillAcceptWithDetails: (details) {
            // don't allow same status movement
            if (details.data.status == taskStatus) return false;
            return true;
          },
          builder: (_, candidateData, rejectedData) {
            return NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverPersistentHeader(
                    pinned: true,
                    delegate: TaskGroupHeaderDelegate(
                        taskStatus: taskStatus, count: tasks?.length)),
              ],
              body: Builder(
                builder: (_) {
                  if (tasks != null && tasks!.isEmpty) {
                    return Column(
                      children: [
                        100.verticalSpace,
                        LottieBuilder.asset(AppAssets.emptyLottie,
                            height: 250.h),
                        Text(taskStatus.emptyStateTitle,
                            style: context.theme.textTheme.headlineLarge),
                      ],
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks?.length ?? 5,
                    physics: ClampingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
                    itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Builder(
                        builder: (_) {
                          if (tasks == null) return TaskCardShimmerWidget();

                          Widget child = TaskCardWidget(
                              task: tasks![index],
                              key: ValueKey(
                                  '${taskStatus.index}${tasks![index].id}'));

                          return Listener(
                            onPointerMove: (PointerMoveEvent event) {
                              if (isDragging && event.delta.dx != 0) {
                                parentScrollController.jumpTo(
                                    parentScrollController.offset +
                                        event.delta.dx * 2.5);
                              }
                            },
                            child: LongPressDraggable(
                              onDragCompleted: () {
                                isDragging = false;
                              },
                              onDragStarted: () {
                                isDragging = true;
                              },
                              data: tasks![index],
                              feedback: Transform.scale(
                                  // scale: .9,
                                  scaleX: .8,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 14,
                                              spreadRadius: 4,
                                              offset: const Offset(0, 3),
                                              color: taskStatus.color
                                                  .withAlpha(13),
                                            )
                                          ]),
                                      child: child)),
                              childWhenDragging:
                                  Opacity(opacity: .5, child: child),
                              child: child,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
