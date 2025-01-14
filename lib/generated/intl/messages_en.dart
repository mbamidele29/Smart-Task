// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(date, time) => "Created date: ${date} at ${time}";

  static String m1(date) => "Due date: ${date}";

  static String m2(hour) =>
      " ${Intl.plural(hour, one: '${hour} hour', other: '${hour} hours')}";

  static String m3(minute) =>
      " ${Intl.plural(minute, one: '${minute} minute', other: '${minute} minutes')}";

  static String m4(seconds) => "${seconds} seconds";

  static String m5(time) => "Time spent on task: ${time}";

  static String m6(count) =>
      "Tracking ${Intl.plural(count, one: '${count} task', other: '${count} tasks')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addComment": MessageLookupByLibrary.simpleMessage("Add Comment"),
        "anErrorOccurred":
            MessageLookupByLibrary.simpleMessage("an error occurred"),
        "cannotMovebackward": MessageLookupByLibrary.simpleMessage(
            "cannot move backward in more than 1 pace"),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "comments": MessageLookupByLibrary.simpleMessage("Comments"),
        "connectionTimedout": MessageLookupByLibrary.simpleMessage(
            "Connection Timeout. Please try again later or check your connection."),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createNewProject":
            MessageLookupByLibrary.simpleMessage("Create New Project"),
        "createdDate": m0,
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dueDate": MessageLookupByLibrary.simpleMessage("Due Date"),
        "dueDate_": m1,
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "high": MessageLookupByLibrary.simpleMessage("High"),
        "hours": m2,
        "hurray": MessageLookupByLibrary.simpleMessage("Hurray 🎉"),
        "inProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
        "low": MessageLookupByLibrary.simpleMessage("Low"),
        "medium": MessageLookupByLibrary.simpleMessage("Medium"),
        "minutes": m3,
        "newTaskFor": MessageLookupByLibrary.simpleMessage("New Task For"),
        "noCommentForThisTask": MessageLookupByLibrary.simpleMessage(
            "No Comment for this task.\nTap the message button at the top right corner to create one"),
        "noDoneTasks": MessageLookupByLibrary.simpleMessage("No Done Tasks"),
        "noInprogressTasks":
            MessageLookupByLibrary.simpleMessage("No In Progress Tasks"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("no internet connection"),
        "noProjectSelected":
            MessageLookupByLibrary.simpleMessage("No project selected"),
        "noTodotasks": MessageLookupByLibrary.simpleMessage("No ToDo Tasks"),
        "notSet": MessageLookupByLibrary.simpleMessage("Not set"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "ongoingTask": MessageLookupByLibrary.simpleMessage("Ongoing Tasks"),
        "pleaseSelectAProject":
            MessageLookupByLibrary.simpleMessage("Please select a project"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage(
            "Please wait while we set up your projects.\nThis will take a few seconds..."),
        "priority": MessageLookupByLibrary.simpleMessage("Priority"),
        "projectCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Project created successfully"),
        "projectName": MessageLookupByLibrary.simpleMessage("Project Name"),
        "seconds": m4,
        "startTracking": MessageLookupByLibrary.simpleMessage("Start Tracking"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "stopTracking": MessageLookupByLibrary.simpleMessage("Stop Tracking"),
        "taskCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Task created successfully"),
        "taskUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Task updated successfully"),
        "thisFieldIsRequired":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "timeSpentOnTask": m5,
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "todo": MessageLookupByLibrary.simpleMessage("To Do"),
        "tracking": MessageLookupByLibrary.simpleMessage("Tracking"),
        "trackingOngoingTasks": m6,
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "urgent": MessageLookupByLibrary.simpleMessage("Urgent"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back"),
        "youCompletedATask":
            MessageLookupByLibrary.simpleMessage("You completed a task")
      };
}
