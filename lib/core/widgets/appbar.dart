import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartTaskAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final double elevation;
  final Widget? trailing;
  final bool centerTitle;
  final String? titleText;
  final Widget? titleWidget;
  final double? appBarHeight;
  const SmartTaskAppBar({
    super.key,
    this.leading,
    this.trailing,
    this.titleText,
    this.titleWidget,
    this.appBarHeight,
    this.elevation = 0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: appBarHeight,
      title: titleWidget ?? Text(titleText ?? ''),
      actions: trailing == null ? [] : [trailing!],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 56.h);
}
