import 'dart:io';

String readFile(String name) =>
    File('test/core/data/store/$name').readAsStringSync();
