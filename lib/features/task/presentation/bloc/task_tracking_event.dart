part of 'task_tracking_bloc.dart';

sealed class TaskTrackingEvent extends Equatable {
  const TaskTrackingEvent();

  @override
  List<Object> get props => [];
}

class StartTrackingEvent extends TaskTrackingEvent {
  final TaskEntity task;
  const StartTrackingEvent(this.task);
}

class StopTrackingEvent extends TaskTrackingEvent {
  final TaskEntity task;
  const StopTrackingEvent(this.task);
}

class StartTickerTrackingEvent extends TaskTrackingEvent {
  final TaskEntity task;
  const StartTickerTrackingEvent(this.task);
}

class StopTickerTrackingEvent extends TaskTrackingEvent {
  final TaskEntity task;
  const StopTickerTrackingEvent(this.task);
}

class _TickerTrackingEvent extends TaskTrackingEvent {
  final TaskEntity task;
  final Duration duration;
  const _TickerTrackingEvent(this.task, this.duration);
}

class SaveAllTrackingEvent extends TaskTrackingEvent {
  const SaveAllTrackingEvent();
}
