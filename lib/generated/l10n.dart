// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `To Do`
  String get todo {
    return Intl.message(
      'To Do',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Urgent`
  String get urgent {
    return Intl.message(
      'Urgent',
      name: 'urgent',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get notSet {
    return Intl.message(
      'Not set',
      name: 'notSet',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get dueDate {
    return Intl.message(
      'Due Date',
      name: 'dueDate',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `New Task For`
  String get newTaskFor {
    return Intl.message(
      'New Task For',
      name: 'newTaskFor',
      desc: '',
      args: [],
    );
  }

  /// `Due date: {date}`
  String dueDate_(Object date) {
    return Intl.message(
      'Due date: $date',
      name: 'dueDate_',
      desc: '',
      args: [date],
    );
  }

  /// `an error occurred`
  String get anErrorOccurred {
    return Intl.message(
      'an error occurred',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Created date: {date} at {time}`
  String createdDate(Object date, Object time) {
    return Intl.message(
      'Created date: $date at $time',
      name: 'createdDate',
      desc: '',
      args: [date, time],
    );
  }

  /// `Time spent on task: {time}`
  String timeSpentOnTask(Object time) {
    return Intl.message(
      'Time spent on task: $time',
      name: 'timeSpentOnTask',
      desc: '',
      args: [time],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please select a project`
  String get pleaseSelectAProject {
    return Intl.message(
      'Please select a project',
      name: 'pleaseSelectAProject',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get tracking {
    return Intl.message(
      'Tracking',
      name: 'tracking',
      desc: '',
      args: [],
    );
  }

  /// `Hurray 🎉`
  String get hurray {
    return Intl.message(
      'Hurray 🎉',
      name: 'hurray',
      desc: '',
      args: [],
    );
  }

  /// `Add Comment`
  String get addComment {
    return Intl.message(
      'Add Comment',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `{seconds} seconds`
  String seconds(Object seconds) {
    return Intl.message(
      '$seconds seconds',
      name: 'seconds',
      desc: '',
      args: [seconds],
    );
  }

  /// `Ongoing Tasks`
  String get ongoingTask {
    return Intl.message(
      'Ongoing Tasks',
      name: 'ongoingTask',
      desc: '',
      args: [],
    );
  }

  /// `Stop Tracking`
  String get stopTracking {
    return Intl.message(
      'Stop Tracking',
      name: 'stopTracking',
      desc: '',
      args: [],
    );
  }

  /// `Start Tracking`
  String get startTracking {
    return Intl.message(
      'Start Tracking',
      name: 'startTracking',
      desc: '',
      args: [],
    );
  }

  /// `You completed a task`
  String get youCompletedATask {
    return Intl.message(
      'You completed a task',
      name: 'youCompletedATask',
      desc: '',
      args: [],
    );
  }

  /// ` {hour, plural, one{{hour} hour} other{{hour} hours}}`
  String hours(num hour) {
    return Intl.message(
      ' ${Intl.plural(hour, one: '$hour hour', other: '$hour hours')}',
      name: 'hours',
      desc: '',
      args: [hour],
    );
  }

  /// ` {minute, plural, one{{minute} minute} other{{minute} minutes}}`
  String minutes(num minute) {
    return Intl.message(
      ' ${Intl.plural(minute, one: '$minute minute', other: '$minute minutes')}',
      name: 'minutes',
      desc: '',
      args: [minute],
    );
  }

  /// `Tracking {count, plural, one{{count} task} other{{count} tasks}}`
  String trackingOngoingTasks(num count) {
    return Intl.message(
      'Tracking ${Intl.plural(count, one: '$count task', other: '$count tasks')}',
      name: 'trackingOngoingTasks',
      desc: '',
      args: [count],
    );
  }

  /// `Project Name`
  String get projectName {
    return Intl.message(
      'Project Name',
      name: 'projectName',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create New Project`
  String get createNewProject {
    return Intl.message(
      'Create New Project',
      name: 'createNewProject',
      desc: '',
      args: [],
    );
  }

  /// `No project selected`
  String get noProjectSelected {
    return Intl.message(
      'No project selected',
      name: 'noProjectSelected',
      desc: '',
      args: [],
    );
  }

  /// `No ToDo Tasks`
  String get noTodotasks {
    return Intl.message(
      'No ToDo Tasks',
      name: 'noTodotasks',
      desc: '',
      args: [],
    );
  }

  /// `No In Progress Tasks`
  String get noInprogressTasks {
    return Intl.message(
      'No In Progress Tasks',
      name: 'noInprogressTasks',
      desc: '',
      args: [],
    );
  }

  /// `No Done Tasks`
  String get noDoneTasks {
    return Intl.message(
      'No Done Tasks',
      name: 'noDoneTasks',
      desc: '',
      args: [],
    );
  }

  /// `Task created successfully`
  String get taskCreatedSuccessfully {
    return Intl.message(
      'Task created successfully',
      name: 'taskCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Task updated successfully`
  String get taskUpdatedSuccessfully {
    return Intl.message(
      'Task updated successfully',
      name: 'taskUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Project created successfully`
  String get projectCreatedSuccessfully {
    return Intl.message(
      'Project created successfully',
      name: 'projectCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `no internet connection`
  String get noInternetConnection {
    return Intl.message(
      'no internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `cannot move backward in more than 1 pace`
  String get cannotMovebackward {
    return Intl.message(
      'cannot move backward in more than 1 pace',
      name: 'cannotMovebackward',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while we set up your projects.\nThis will take a few seconds...`
  String get pleaseWait {
    return Intl.message(
      'Please wait while we set up your projects.\nThis will take a few seconds...',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Connection Timeout. Please try again later or check your connection.`
  String get connectionTimedout {
    return Intl.message(
      'Connection Timeout. Please try again later or check your connection.',
      name: 'connectionTimedout',
      desc: '',
      args: [],
    );
  }

  /// `No Comment for this task.\nTap the message button at the top right corner to create one`
  String get noCommentForThisTask {
    return Intl.message(
      'No Comment for this task.\nTap the message button at the top right corner to create one',
      name: 'noCommentForThisTask',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
