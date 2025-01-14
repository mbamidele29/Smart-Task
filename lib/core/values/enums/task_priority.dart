import 'package:flutter/material.dart';
import 'package:smart_task/generated/l10n.dart';

enum TaskPriorityEnum {
  low(1, Color(0xFF2F80ED)),
  medium(2, Color(0xFF219653)),
  high(3, Color(0xFFF2994A)),
  urgent(4, Color(0xFFEB5757));

  final int code;
  final Color color;

  const TaskPriorityEnum(this.code, this.color);

  @override
  String toString() => name;
}

extension TaskPriorityEnumExt on TaskPriorityEnum {
  String get name {
    switch (this) {
      case TaskPriorityEnum.low:
        return S.current.low;
      case TaskPriorityEnum.medium:
        return S.current.medium;
      case TaskPriorityEnum.high:
        return S.current.high;
      case TaskPriorityEnum.urgent:
        return S.current.urgent;
    }
  }
}
