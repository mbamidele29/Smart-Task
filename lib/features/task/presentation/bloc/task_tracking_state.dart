part of 'task_tracking_bloc.dart';

class TaskTrackingState {
  final Map<TaskEntity, DateTime> tracker;
  const TaskTrackingState(this.tracker);
}

class TaskTrackingDurationState extends TaskTrackingState {
  final TaskEntity task;
  final Duration duration;

  TaskTrackingDurationState(super.tracker,
      {required this.task, required this.duration});
}

class TickerTrackingDurationState extends TaskTrackingState {
  final TaskEntity task;
  final Duration duration;

  TickerTrackingDurationState(super.tracker,
      {required this.task, required this.duration});
}
