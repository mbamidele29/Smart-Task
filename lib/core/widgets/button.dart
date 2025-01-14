import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_task/core/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/widgets/loading.dart';

class AppButtonWidget extends StatelessWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final bool isLoading;
  final double? fontSize;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? color, borderColor, textColor;
  const AppButtonWidget({
    super.key,
    this.onPressed,
    this.child,
    this.text,
    this.color,
    this.width,
    this.height,
    this.fontSize,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.verticalPadding,
    this.isLoading = false,
    this.horizontalPadding,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 1.sw,
      height: height ?? 48.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ElevatedButton(
              onPressed: onPressed == null
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      onPressed!();
                    },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: color ?? AppColors.blue,
                  fixedSize: Size(width ?? 1.sw, height ?? 48.h),
                  disabledBackgroundColor: AppColors.blue.withAlpha(100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
                    side: BorderSide(
                        color: onPressed == null
                            ? Colors.transparent
                            : borderColor ?? Colors.transparent),
                  )),
              child: text != null
                  ? Center(
                      child: Text(text!,
                          style: context.theme.textTheme.headlineMedium
                              ?.copyWith(
                                  color: context.theme.colorScheme.onPrimary)))
                  : child),
          if (isLoading)
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                    width: width ?? 1.sw,
                    height: height ?? 48.h,
                    color: Colors.black.withAlpha(102),
                    child: AppLoadingWidget()),
              ),
            ),
        ],
      ),
    );
  }
}
