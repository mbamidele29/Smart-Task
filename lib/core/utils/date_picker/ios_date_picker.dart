import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task/generated/l10n.dart';

Future<DateTime?> showIosDatePicker(BuildContext context,
    DateTime? initialValue, DateTime? minDate, DateTime? maxDate) async {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 550.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.r))),
      child: Column(
        children: [
          SizedBox(
            height: 400.h,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialValue,
              onDateTimeChanged: (val) {
                context.pop(val);
              },
              minimumYear: minDate?.year ?? 1,
              maximumYear: maxDate?.year,
            ),
          ),

          // Close the modal
          CupertinoButton(onPressed: context.pop, child: Text(S.current.ok))
        ],
      ),
    ),
  ).then((val) {
    if (val is DateTime?) return val;
  });
  return null;
}
