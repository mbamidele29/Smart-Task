import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_task/core/models/push_notification_payload.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/usecases/cancel_push_notification_usecase.dart';
import 'package:smart_task/features/task/domain/usecases/send_push_notification_usecase.dart';
import 'package:smart_task/generated/l10n.dart';

part 'task_tracking_event.dart';
part 'task_tracking_state.dart';

class TaskTrackingBloc extends Bloc<TaskTrackingEvent, TaskTrackingState> {
  StreamSubscription? _tickerSubscription;
  final int _ongoingTaskNotificationId = 899;
  final SendPushNotificationUsecase sendPushNotification;
  final CancelPushNotificationUsecase cancelPushNotification;

  TaskTrackingBloc(this.sendPushNotification, this.cancelPushNotification)
      : super(TaskTrackingState({})) {
    on<StopTrackingEvent>(_stopTrackingHandler);
    on<StartTrackingEvent>(_startTrackingHandler);
    on<_TickerTrackingEvent>(_tickerTrackingHandler);
    on<SaveAllTrackingEvent>(_saveAllTrackingHandler);
    on<StopTickerTrackingEvent>(_stopTickerTrackingHandler);
    on<StartTickerTrackingEvent>(_startTickerTrackingHandler);
  }

  void _sendPushNotification() async {
    var payload = PushNotificationPayload(
        title: S.current.ongoingTask,
        id: _ongoingTaskNotificationId,
        body: S.current.trackingOngoingTasks(state.tracker.length));

    await cancelPushNotification(payload);

    int length = state.tracker.length;
    if (length > 0) {
      await sendPushNotification(payload);
    }
  }

  Future _startTrackingHandler(StartTrackingEvent event, emit) async {
    if (state.tracker.containsKey(event.task)) return;

    state.tracker[event.task] = DateTime.now()
        .subtract(Duration(minutes: event.task.durationInMinute ?? 0));
    emit(TaskTrackingState(state.tracker));
    _sendPushNotification();
  }

  Future _saveAllTrackingHandler(SaveAllTrackingEvent event, emit) async {
    for (TaskEntity task in state.tracker.keys) {
      emit(TaskTrackingDurationState(state.tracker,
          task: task,
          duration: DateTime.now().difference(state.tracker[task]!)));
    }
  }

  Future _stopTrackingHandler(StopTrackingEvent event, emit) async {
    DateTime? startTime = state.tracker[event.task];
    if (startTime == null) return;

    emit(TaskTrackingDurationState(state.tracker,
        task: event.task, duration: DateTime.now().difference(startTime)));

    state.tracker.remove(event.task);
    add(StopTickerTrackingEvent(event.task));
    emit(TaskTrackingState(state.tracker));
    _sendPushNotification();
  }

  Future _stopTickerTrackingHandler(StopTickerTrackingEvent event, emit) async {
    _tickerSubscription?.cancel();
  }

  Future _tickerTrackingHandler(_TickerTrackingEvent event, emit) async {
    emit(TickerTrackingDurationState(state.tracker,
        task: event.task, duration: event.duration));
  }

  Future _startTickerTrackingHandler(
      StartTickerTrackingEvent event, emit) async {
    _tickerSubscription?.cancel();

    DateTime? startTime = state.tracker[event.task];
    if (startTime == null) return;

    _tickerSubscription = Stream.periodic(Duration(seconds: 1)).listen((_) =>
        add(_TickerTrackingEvent(
            event.task, DateTime.now().difference(startTime))));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
