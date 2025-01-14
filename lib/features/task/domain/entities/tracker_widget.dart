import 'package:flutter/material.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/utils/extensions/num_ext.dart';
import 'package:smart_task/core/widgets/chip.dart';
import 'package:smart_task/core/values/colors.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

class TrackerWidget extends StatefulWidget {
  final TaskEntity task;
  final bool showElapsedTime;

  const TrackerWidget(
      {super.key, required this.showElapsedTime, required this.task});

  @override
  State<TrackerWidget> createState() => _TrackerWidgetState();
}

class _TrackerWidgetState extends State<TrackerWidget> {
  @override
  void dispose() {
    serviceLocator<TaskTrackingBloc>()
        .add(StopTickerTrackingEvent(widget.task));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? ellapsed;
    return BlocBuilder(
      bloc: serviceLocator<TaskTrackingBloc>(),
      builder: (_, state) {
        bool isTracking = serviceLocator<TaskTrackingBloc>()
            .state
            .tracker
            .containsKey(widget.task);
        if (!isTracking) return SizedBox.shrink();

        if (isTracking && widget.showElapsedTime) {
          serviceLocator<TaskTrackingBloc>()
              .add(StartTickerTrackingEvent(widget.task));
        }

        if (state is TickerTrackingDurationState &&
            state.task == widget.task &&
            widget.showElapsedTime) {
          ellapsed = '';
          ellapsed = state.duration.inSeconds.formattedFromSecondTime;
        }

        return AppChipWidget(
          name: ellapsed ?? S.current.tracking,
          hasDot: false,
          color: AppColors.blue,
          textColor: Colors.white,
          borderColor: AppColors.blue,
        );
      },
    );
  }
}
