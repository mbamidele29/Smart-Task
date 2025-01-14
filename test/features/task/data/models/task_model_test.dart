import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task/features/task/data/models/task.dart';

import '../../../../core/utils/file_reader.dart';

void main() {
  setUp(() {});

  test('should return TaskModel from json file', () {
    Map<String, dynamic> data = jsonDecode(readFile('task.json'));

    final result = TaskModel.fromJson(data);

    expect(result.id, '1');
  });
}
