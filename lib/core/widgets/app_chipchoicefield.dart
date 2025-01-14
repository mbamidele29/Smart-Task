import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/widgets/form_label.dart';

typedef AppChipBuilder<T, bool> = Widget Function(T item, bool isSelected);

class AppChipchoicefieldWidget<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final String? headerText;
  final ValueChanged<T?>? onSaved;
  final ValueChanged<T?>? onChanged;
  final AppChipBuilder<T, bool>? builder;
  final FormFieldValidator<T>? validator;
  const AppChipchoicefieldWidget(
      {super.key,
      this.onSaved,
      this.builder,
      this.onChanged,
      this.validator,
      this.headerText,
      this.initialValue,
      required this.items});

  @override
  State<AppChipchoicefieldWidget<T>> createState() =>
      _AppChipchoicefieldWidgetState<T>();
}

class _AppChipchoicefieldWidgetState<T>
    extends State<AppChipchoicefieldWidget<T>> {
  Color? color;
  Color? errorBorderColor;
  EdgeInsetsGeometry? padding;
  BorderRadiusGeometry? borderRadius;

  T? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setProperties();

    return FormField<T>(
      validator: widget.validator,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabelWidget(headerText: widget.headerText),
          Container(
            width: 1.sw,
            padding: padding,
            decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
                border: Border.all(
                    color: (state.hasError ? errorBorderColor : color) ??
                        Colors.transparent)),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 8.h,
              children: widget.items.map((T item) {
                bool selected = _selectedItem == item;

                return widget.builder != null
                    ? GestureDetector(
                        onTap: () => _onChange(item, state),
                        child: widget.builder?.call(item, selected))
                    : FilterChip(
                        showCheckmark: false,
                        labelPadding: EdgeInsets.zero,
                        backgroundColor: color,
                        tooltip: item.toString(),
                        selectedColor: context.theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        labelStyle: context.theme.textTheme.labelSmall
                            ?.copyWith(
                                fontSize: 12.sp,
                                color: selected
                                    ? context.theme.colorScheme.onPrimary
                                    : context.theme.colorScheme.primary),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        label: Text(item.toString()),
                        selected: selected,
                        onSelected: (_) => _onChange(item, state),
                      );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _onChange(T item, FormFieldState<T> state) {
    if (item == _selectedItem) {
      _selectedItem = null;
    } else {
      _selectedItem = item;
    }

    state.didChange(item);

    setState(() {});
  }

  _setProperties() {
    padding = widget.items.isEmpty
        ? null
        : context.theme.inputDecorationTheme.contentPadding;
    color = context.theme.inputDecorationTheme.fillColor;
    errorBorderColor =
        context.theme.inputDecorationTheme.errorBorder?.borderSide.color;

    if (context.theme.inputDecorationTheme.border is OutlineInputBorder) {
      borderRadius =
          (context.theme.inputDecorationTheme.border as OutlineInputBorder)
              .borderRadius;
    }
  }
}
