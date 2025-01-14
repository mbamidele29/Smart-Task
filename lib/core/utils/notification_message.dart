import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/values/fonts.dart';

abstract class NotificationMessenger {
  static showError(BuildContext context, String message) {
    if (message.isEmpty) return;

    _showMessage(context, message: message, isError: true);
  }

  static showSuccess(BuildContext context, String message) {
    if (message.isEmpty) return;
    _showMessage(context, message: message, isError: false);
  }

  static Future _showMessage(BuildContext context,
      {required String message, required bool isError}) async {
    OverlayEntry? overlayEntry;
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // top: 95.h,
        left: 20.w,
        right: 20.w,
        child: _Messenger(
          message: message,
          textColor:
              isError ? const Color(0xFFEB5757) : const Color(0xFF219653),
          backgroundColor:
              isError ? const Color(0xFFE6D0D0) : const Color(0xFFC8D9CF),
        ),
      ),
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 3));
    if (overlayEntry.mounted == true) {
      overlayEntry.remove();
    }
  }
}

class _Messenger extends StatefulWidget {
  final String message;
  final Color textColor;
  final Color backgroundColor;

  const _Messenger(
      {required this.message,
      required this.textColor,
      required this.backgroundColor});

  @override
  State<_Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<_Messenger>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 600),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(_controller!);
    _controller?.forward(from: 0);
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(seconds: 3), () {
          _controller?.reverse(from: 1);
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          // height: 50.h,
          width: 335.w,
          margin: EdgeInsets.only(top: 85.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(widget.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: widget.textColor,
                fontFamily: AppFonts.sora,
                fontWeight: FontWeight.w400,
              )),
        ),
      ),
    );
  }
}
