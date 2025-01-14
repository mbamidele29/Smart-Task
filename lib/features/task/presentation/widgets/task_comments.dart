import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

class TaskCommentsWidget extends StatefulWidget {
  final TaskEntity task;
  const TaskCommentsWidget({super.key, required this.task});

  @override
  State<TaskCommentsWidget> createState() => _TaskCommentsWidgetState();
}

class _TaskCommentsWidgetState extends State<TaskCommentsWidget> {
  List<CommentEntity>? comments;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceLocator<TaskBloc>().add(GetTaskCommentsEvent(widget.task.id));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: serviceLocator<TaskBloc>(),
      builder: (_, state) {
        if (state is GetTaskCommentsSuccess && state.taskId == widget.task.id) {
          comments = state.comments;
        }
        if (state is CreateTaskCommentSuccess &&
            state.comment.taskId == widget.task.id) {
          comments ??= [];
          comments!.insert(0, state.comment);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(S.current.comments,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.headlineMedium),
                ),
                10.horizontalSpace,
                if ((comments ?? []).isNotEmpty)
                  Text('(${comments!.length})',
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.titleSmall
                          ?.copyWith(fontSize: 14.sp)),
              ],
            ),
            12.verticalSpace,
            Builder(builder: (_) {
              if ((comments ?? []).isEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Center(
                    child: Text(
                      S.current.noCommentForThisTask,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: comments!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                        width: 1.w, color: context.theme.colorScheme.secondary),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comments![index].content ?? '',
                        style: context.theme.textTheme.titleSmall?.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      20.verticalSpace,
                      Divider(
                          height: 20.h,
                          thickness: 2,
                          color: context.theme.colorScheme.secondary),
                      Text(
                        S.current.createdDate(
                            DateFormat('d MMMM, y')
                                .format(comments![index].postedAt!),
                            DateFormat('hh:mm')
                                .format(comments![index].postedAt!)),
                        style: context.theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              );
            }),
            8.verticalSpace,
          ],
        );
      },
    );
  }
}
