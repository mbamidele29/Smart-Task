class AttachmentModel {
  final String? fileName;
  final String? fileType;
  final String? fileUrl;
  final String? resourceType;

  AttachmentModel({
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.resourceType,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        fileName: json["file_name"],
        fileType: json["file_type"],
        fileUrl: json["file_url"],
        resourceType: json["resource_type"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_type": fileType,
        "file_url": fileUrl,
        "resource_type": resourceType,
      };
}
