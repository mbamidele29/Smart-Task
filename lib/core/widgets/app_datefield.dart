import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/core/utils/date_picker/android_date_picker.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/utils/date_picker/ios_date_picker.dart';

import 'app_textfield.dart';

class AppDateFieldWidget extends StatefulWidget {
  final bool enabled;
  final String? hintText;
  final String? headerText;
  final DateTime? minDate;
  final DateTime? maxDate;
  final VoidCallback? onTap;
  final DateTime? initialValue;
  final ValueChanged<DateTime?>? onSaved;
  final TextEditingController? controller;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(DateTime?)? validator;

  const AppDateFieldWidget({
    super.key,
    this.onTap,
    this.minDate,
    this.maxDate,
    this.onSaved,
    this.hintText,
    this.onChanged,
    this.validator,
    this.headerText,
    this.controller,
    this.initialValue,
    this.enabled = true,
  });

  @override
  State<AppDateFieldWidget> createState() => _AppDateFieldWidgetState();
}

class _AppDateFieldWidgetState extends State<AppDateFieldWidget> {
  DateTime? _dateTime;
  late TextEditingController controller;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    _setValue(widget.initialValue);
  }

  _setValue(DateTime? dateTime) {
    _dateTime = dateTime;
    String val = _dateTime == null ? '' : _dateFormat.format(_dateTime!);
    controller.text = val;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      readOnly: true,
      controller: controller,
      enabled: widget.enabled,
      hintText: widget.hintText,
      headerText: widget.headerText,
      onSaved: (_) => widget.onSaved?.call(_dateTime),
      validator: (_) => widget.validator?.call(_dateTime),
      onChanged: (_) => widget.onChanged?.call(_dateTime),
      suffixWidget: Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: SvgPicture.asset(
            AppAssets.calendar,
            width: 24.w,
            height: 24.w,
            colorFilter: ColorFilter.mode(
                context.theme.textTheme.labelLarge!.color!, BlendMode.srcIn),
          )),
      onTap: () async {
        if (!widget.enabled) return;

        DateTime? dateTime;
        if (Platform.isIOS) {
          dateTime = await showIosDatePicker(
              context, widget.initialValue, widget.minDate, widget.maxDate);
        } else {
          dateTime = await showAndroidDatePicker(
              context, widget.initialValue, widget.minDate, widget.maxDate);
        }
        _setValue(dateTime);
      },
    );
  }
}
