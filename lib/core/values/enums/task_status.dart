import 'package:flutter/material.dart';
import 'package:smart_task/generated/l10n.dart';

enum TaskStatusEnum {
  todo(1, Color(0xFF5030E5)),
  inProgress(2, Color(0xFFFFA500)),
  done(3, Color(0xFF8BC48A));

  final int code;
  final Color color;

  const TaskStatusEnum(this.code, this.color);

  @override
  String toString() => name;
}

extension TaskStatusEnumExt on TaskStatusEnum {
  String get name {
    switch (this) {
      case TaskStatusEnum.todo:
        return S.current.todo;
      case TaskStatusEnum.inProgress:
        return S.current.inProgress;
      case TaskStatusEnum.done:
        return S.current.done;
    }
  }

  String get emptyStateTitle {
    switch (this) {
      case TaskStatusEnum.todo:
        return S.current.noTodotasks;
      case TaskStatusEnum.inProgress:
        return S.current.noInprogressTasks;
      case TaskStatusEnum.done:
        return S.current.noDoneTasks;
    }
  }
}
