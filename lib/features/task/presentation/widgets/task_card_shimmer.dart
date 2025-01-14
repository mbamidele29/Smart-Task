import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/widgets/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskCardShimmerWidget extends StatelessWidget {
  const TaskCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 1.sw,
        height: 186.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget(width: 50.w, height: 23.h, radius: 5.r),
            12.verticalSpace,
            ShimmerWidget(width: 100.w, height: 23.h, radius: 5.r),
            8.verticalSpace,
            ShimmerWidget(width: 1.sw, height: 15.h),
            4.verticalSpace,
            ShimmerWidget(width: 1.sw - 100.w, height: 15.h),
            4.verticalSpace,
            ShimmerWidget(width: 1.sw - 150.w, height: 15.h),
            10.verticalSpace,
            Row(
              children: [
                SvgPicture.asset(AppAssets.clock, width: 14.w, height: 14.w),
                4.horizontalSpace,
                ShimmerWidget(width: 30.w, height: 15.h, radius: 2.r),
                Spacer(),
                SvgPicture.asset(AppAssets.comment, width: 10.w, height: 10.w),
                4.horizontalSpace,
                ShimmerWidget(width: 30.w, height: 15.h, radius: 2.r),
              ],
            )
          ],
        ),
      ),
    );
  }
}
