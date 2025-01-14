import 'package:equatable/equatable.dart';
import 'package:smart_task/features/task/domain/entities/due_date.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/core/values/enums/task_status.dart';

class TaskEntity extends Equatable {
  final String id;
  final int? order;
  final String content;
  final int? commentCount;
  final bool? isCompleted;
  final DateTime? createdAt;
  final String? description;
  final DateTime? completedAt;
  final int? durationInMinute;
  final DueDateEntity? dueDate;
  final TaskPriorityEnum priority;

  const TaskEntity({
    required this.id,
    required this.order,
    required this.content,
    required this.dueDate,
    required this.priority,
    required this.createdAt,
    required this.isCompleted,
    required this.description,
    required this.completedAt,
    required this.commentCount,
    required this.durationInMinute,
  });

  TaskStatusEnum get status {
    if (isCompleted == true) return TaskStatusEnum.done;
    if (durationInMinute == null) return TaskStatusEnum.todo;
    return TaskStatusEnum.inProgress;
  }

  @override
  List<Object?> get props => [id];
}
