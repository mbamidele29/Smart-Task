import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

class AppLabelWidget extends StatelessWidget {
  final String? headerText;
  const AppLabelWidget({super.key, this.headerText});

  @override
  Widget build(BuildContext context) {
    if (headerText == null) return SizedBox.shrink();

    return Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child:
            Text(headerText ?? '', style: context.theme.textTheme.labelMedium));
  }
}
