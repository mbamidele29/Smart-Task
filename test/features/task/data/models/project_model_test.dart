import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task/features/project/data/models/project.dart';

import '../../../../core/utils/file_reader.dart';

void main() {
  setUp(() {});

  test('should return ProjectModel from json file', () {
    Map<String, dynamic> data = jsonDecode(readFile('project.json'));

    final result = ProjectModel.fromJson(data);

    expect(result.id, '2346291125');
  });
}
