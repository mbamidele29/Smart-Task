import 'package:smart_task/features/project/domain/entities/project.dart';

class ProjectModel extends ProjectEntity {
  final String? url;
  final String? color;
  final bool? isShared;
  final String? parentId;
  final bool? isFavorite;
  final int? commentCount;
  final bool? isTeamInbox;
  final String? viewStyle;
  final bool? isInboxProject;

  const ProjectModel({
    this.url,
    this.color,
    super.order,
    this.parentId,
    this.isShared,
    this.viewStyle,
    this.isFavorite,
    this.isTeamInbox,
    this.commentCount,
    required super.id,
    required super.name,
    this.isInboxProject,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        parentId: json["parent_id"],
        order: json["order"],
        color: json["color"],
        name: json["name"],
        commentCount: json["comment_count"],
        isShared: json["is_shared"],
        isFavorite: json["is_favorite"],
        isInboxProject: json["is_inbox_project"],
        isTeamInbox: json["is_team_inbox"],
        url: json["url"],
        viewStyle: json["view_style"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "order": order,
        "color": color,
        "name": name,
        "comment_count": commentCount,
        "is_shared": isShared,
        "is_favorite": isFavorite,
        "is_inbox_project": isInboxProject,
        "is_team_inbox": isTeamInbox,
        "url": url,
        "view_style": viewStyle,
      };
}
