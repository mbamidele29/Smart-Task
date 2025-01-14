import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

class AppLoadingWidget extends StatefulWidget {
  const AppLoadingWidget({super.key});

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget>
    with SingleTickerProviderStateMixin {
  final int length = 3;
  final int multiplier = 300;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: length * multiplier))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          Duration duration =
              (_controller.duration ?? Duration.zero) * _controller.value;

          int currentIndex =
              (duration.inMilliseconds / multiplier).toInt() % length;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: CircleAvatar(
                          radius: index == currentIndex ? 5.w : 4.w,
                          backgroundColor:
                              context.theme.scaffoldBackgroundColor),
                    )),
          );
        });
  }
}
