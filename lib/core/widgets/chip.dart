import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

class AppChipWidget extends StatelessWidget {
  final String name;
  final bool hasDot;
  final Color? color;
  final Color textColor;
  final Color borderColor;

  const AppChipWidget({
    super.key,
    this.hasDot = true,
    required this.name,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot)
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: CircleAvatar(radius: 4.w, backgroundColor: textColor),
            ),
          Flexible(
            child: Text(
              name,
              maxLines: 1,
              style: context.theme.textTheme.labelSmall?.copyWith(
                  height: 1,
                  fontSize: 12.sp,
                  color: textColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
