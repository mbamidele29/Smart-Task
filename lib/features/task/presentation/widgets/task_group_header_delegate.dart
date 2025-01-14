import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task/core/navigation/routes.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/values/enums/task_status.dart';
import 'package:smart_task/core/widgets/icon_button.dart';

class TaskGroupHeaderDelegate extends SliverPersistentHeaderDelegate {
  final int? count;
  final TaskStatusEnum taskStatus;

  TaskGroupHeaderDelegate({required this.count, required this.taskStatus});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double borderWidth =
        3.w - ((3.w - 1.5.w) * (1 - _scrollAnimationValue(shrinkOffset)));

    return Container(
      height: maxExtent,
      color: context.theme.colorScheme.secondary,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: borderWidth, color: taskStatus.color)),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 4.w, backgroundColor: taskStatus.color),
            8.horizontalSpace,
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(taskStatus.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ),
                  if (count != null)
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: CircleAvatar(
                        radius: 10.w,
                        backgroundColor: context.theme.colorScheme.primary,
                        child: Text('$count',
                            maxLines: 1,
                            style: context.theme.textTheme.headlineSmall
                                ?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        context.theme.colorScheme.onPrimary)),
                      ),
                    ),
                ],
              ),
            ),
            if (taskStatus == TaskStatusEnum.todo)
              SmartTaskIconButtonWidget(
                width: 24.w,
                height: 24.w,
                svgPath: AppAssets.plus,
                iconColor: taskStatus.color,
                buttonColor: taskStatus.color.withAlpha(40),
                onPressed: () => context.push(NavigationRoutes.createTask),
              ),
          ],
        ),
      ),
    );
  }

  double _scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 48.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
