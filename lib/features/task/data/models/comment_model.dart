import 'package:smart_task/features/task/data/models/attachment_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  final String? projectId;
  final AttachmentModel? attachment;

  const CommentModel({
    required super.id,
    required super.taskId,
    required super.content,
    required super.postedAt,
    required this.projectId,
    required this.attachment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        content: json["content"],
        id: json["id"],
        postedAt: json["posted_at"] == null
            ? null
            : DateTime.parse(json["posted_at"]),
        projectId: json["project_id"],
        taskId: json["task_id"],
        attachment: json["attachment"] == null
            ? null
            : AttachmentModel.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "id": id,
        "posted_at": postedAt?.toIso8601String(),
        "project_id": projectId,
        "task_id": taskId,
        "attachment": attachment?.toJson(),
      };
}
