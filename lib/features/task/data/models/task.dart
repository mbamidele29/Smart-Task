import 'package:smart_task/features/task/data/models/duration.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';

import 'due_date_model.dart';

class TaskModel extends TaskEntity {
  final String? url;
  final String? sectionId;
  final DueDateModel? due;
  final int? priorityValue;
  final DurationModel? duration;

  final String? parentId;
  final String? projectId;
  final String? creatorId;
  final String? assigneeId;
  final String? assignerId;
  final List<String>? labels;

  TaskModel({
    required super.id,
    required this.url,
    required this.due,
    required super.order,
    required this.labels,
    required super.content,
    required this.duration,
    required this.parentId,
    required this.sectionId,
    required this.projectId,
    required this.creatorId,
    required super.createdAt,
    required this.assigneeId,
    required this.assignerId,
    required super.isCompleted,
    required super.description,
    required super.completedAt,
    required this.priorityValue,
    required super.commentCount,
  }) : super(
          dueDate: due,
          durationInMinute: duration?.toMinute(),
          priority: TaskPriorityEnum.values.firstWhere(
              (e) => e.code == priorityValue,
              orElse: () => TaskPriorityEnum.low),
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        completedAt: null,
        creatorId: json["creator_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        assigneeId: json["assignee_id"],
        assignerId: json["assigner_id"],
        commentCount: json["comment_count"],
        isCompleted: json["is_completed"],
        content: json["content"],
        description: json["description"],
        due: json["due"] == null ? null : DueDateModel.fromJson(json["due"]),
        duration: json["duration"] == null
            ? null
            : DurationModel.fromJson(json["duration"]),
        id: json["id"],
        labels: json["labels"] == null
            ? []
            : List<String>.from(json["labels"]!.map((x) => x)),
        order: json["order"],
        priorityValue: json["priority"],
        projectId: json["project_id"],
        sectionId: json["section_id"],
        parentId: json["parent_id"],
        url: json["url"],
      );

  TaskModel copyWith(
      {int? durationInMinute, bool? isCompleted, bool? unsetDuration}) {
    return TaskModel(
        id: id,
        url: url,
        due: due,
        order: order,
        labels: labels,
        content: content,
        duration: duration,
        parentId: parentId,
        sectionId: sectionId,
        projectId: projectId,
        creatorId: creatorId,
        createdAt: createdAt,
        assigneeId: assigneeId,
        assignerId: assignerId,
        isCompleted: isCompleted,
        description: description,
        completedAt: completedAt,
        priorityValue: priorityValue,
        commentCount: commentCount);
  }

  Map<String, dynamic> toJson() => {
        "creator_id": creatorId,
        "created_at": createdAt?.toIso8601String(),
        "assignee_id": assigneeId,
        "assigner_id": assignerId,
        "comment_count": commentCount,
        "is_completed": isCompleted,
        "content": content,
        "description": description,
        "due": due?.toJson(),
        "duration": duration?.toJson(),
        "id": id,
        "labels":
            labels == null ? null : List<dynamic>.from(labels!.map((x) => x)),
        "order": order,
        "priority": priorityValue,
        "project_id": projectId,
        "section_id": sectionId,
        "parent_id": parentId,
        "url": url,
      };
}
