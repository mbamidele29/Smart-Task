import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

class SmartTaskIconButtonWidget extends StatelessWidget {
  final double? width;
  final String svgPath;
  final double? height;
  final double? iconSize;
  final Color? iconColor;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  const SmartTaskIconButtonWidget(
      {super.key,
      this.width,
      this.height,
      this.iconSize,
      this.iconColor,
      this.buttonColor,
      required this.svgPath,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints:
          BoxConstraints(maxWidth: width ?? 32.w, maxHeight: height ?? 32.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      onPressed: onPressed,
      child: Container(
        width: width ?? 32.w,
        height: height ?? 32.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: buttonColor ?? context.theme.colorScheme.secondary,
        ),
        child: SvgPicture.asset(
          svgPath,
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
              iconColor ?? context.theme.colorScheme.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}
