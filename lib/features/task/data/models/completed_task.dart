import 'package:smart_task/features/task/data/models/duration.dart';
import 'package:smart_task/features/task/data/models/task.dart';

import 'due_date_model.dart';

class CompletedTasksModel extends TaskModel {
  CompletedTasksModel({
    required super.id,
    required super.url,
    required super.due,
    required super.order,
    required super.labels,
    required super.content,
    required super.duration,
    required super.parentId,
    required super.projectId,
    required super.sectionId,
    required super.creatorId,
    required super.createdAt,
    required super.assigneeId,
    required super.assignerId,
    required super.isCompleted,
    required super.description,
    required super.completedAt,
    required super.commentCount,
    required super.priorityValue,
  });

  factory CompletedTasksModel.fromJson(Map<String, dynamic> json) {
    ItemObject? item = json["item_object"] == null
        ? null
        : ItemObject.fromJson(json["item_object"]);
    return CompletedTasksModel(
      id: json["task_id"],
      content: json["content"],
      completedAt: json["completed_at"] == null
          ? null
          : DateTime.parse(json["completed_at"]),
      projectId: json["project_id"],
      sectionId: json["section_id"],
      url: null,
      due: json["due"] == null ? null : DueDateModel.fromJson(json["due"]),
      order: item?.childOrder,
      labels: item?.labels,
      duration: item?.duration,
      creatorId: null,
      assigneeId: null,
      assignerId: null,
      isCompleted: true,
      commentCount: null,
      parentId: item?.parentId,
      createdAt: item?.addedAt,
      priorityValue: item?.priority,
      description: item?.description,
    );
  }
}

class ItemObject {
  final DateTime? addedAt;
  final String? addedByUid;
  final dynamic assignedByUid;
  final bool? checked;
  final int? childOrder;
  final bool? collapsed;
  final DateTime? completedAt;
  final String? content;
  final dynamic deadline;
  final String? description;
  final DueDateModel? due;
  final DurationModel? duration;
  final String? id;
  final bool? isDeleted;
  final List<String>? labels;
  final String? parentId;
  final int? priority;
  final String? projectId;
  final dynamic responsibleUid;
  final dynamic sectionId;
  final dynamic syncId;
  final DateTime? updatedAt;
  final String? userId;
  final String? v2Id;
  final dynamic v2ParentId;
  final String? v2ProjectId;
  final dynamic v2SectionId;

  ItemObject({
    this.addedAt,
    this.addedByUid,
    this.assignedByUid,
    this.checked,
    this.childOrder,
    this.collapsed,
    this.completedAt,
    this.content,
    this.deadline,
    this.description,
    this.due,
    this.duration,
    this.id,
    this.isDeleted,
    this.labels,
    this.parentId,
    this.priority,
    this.projectId,
    this.responsibleUid,
    this.sectionId,
    this.syncId,
    this.updatedAt,
    this.userId,
    this.v2Id,
    this.v2ParentId,
    this.v2ProjectId,
    this.v2SectionId,
  });

  factory ItemObject.fromJson(Map<String, dynamic> json) => ItemObject(
        addedAt:
            json["added_at"] == null ? null : DateTime.parse(json["added_at"]),
        addedByUid: json["added_by_uid"],
        assignedByUid: json["assigned_by_uid"],
        checked: json["checked"],
        childOrder: json["child_order"],
        collapsed: json["collapsed"],
        completedAt: json["completed_at"] == null
            ? null
            : DateTime.parse(json["completed_at"]),
        content: json["content"],
        deadline: json["deadline"],
        description: json["description"],
        due: json["due"] == null ? null : DueDateModel.fromJson(json["due"]),
        duration: json["duration"] == null
            ? null
            : DurationModel.fromJson(json["duration"]),
        id: json["id"],
        isDeleted: json["is_deleted"],
        labels: json["labels"] == null ? [] : List<String>.from(json["labels"]),
        parentId: json["parent_id"],
        priority: json["priority"],
        projectId: json["project_id"],
        responsibleUid: json["responsible_uid"],
        sectionId: json["section_id"],
        syncId: json["sync_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        v2Id: json["v2_id"],
        v2ParentId: json["v2_parent_id"],
        v2ProjectId: json["v2_project_id"],
        v2SectionId: json["v2_section_id"],
      );

  Map<String, dynamic> toJson() => {
        "added_at": addedAt?.toIso8601String(),
        "added_by_uid": addedByUid,
        "assigned_by_uid": assignedByUid,
        "checked": checked,
        "child_order": childOrder,
        "collapsed": collapsed,
        "completed_at": completedAt?.toIso8601String(),
        "content": content,
        "deadline": deadline,
        "description": description,
        "due": due,
        "duration": duration,
        "id": id,
        "is_deleted": isDeleted,
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
        "parent_id": parentId,
        "priority": priority,
        "project_id": projectId,
        "responsible_uid": responsibleUid,
        "section_id": sectionId,
        "sync_id": syncId,
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "v2_id": v2Id,
        "v2_parent_id": v2ParentId,
        "v2_project_id": v2ProjectId,
        "v2_section_id": v2SectionId,
      };
}
