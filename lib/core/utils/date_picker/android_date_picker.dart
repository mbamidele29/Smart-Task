import 'package:flutter/material.dart';

Future<DateTime?> showAndroidDatePicker(BuildContext context,
    DateTime? initialValue, DateTime? minDate, DateTime? maxDate) async {
  return showDatePicker(
      context: context,
      initialDate: initialValue,
      lastDate: DateTime(9999),
      firstDate: minDate ?? DateTime(2000));
}
