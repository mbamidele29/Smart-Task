import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final int? order;
  final String name;

  const ProjectEntity(
      {required this.id, required this.name, required this.order});

  @override
  List<Object?> get props => [id, name, order];
}
