import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/utils/notification_message.dart';
import 'package:smart_task/core/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/values/enums/task_status.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/widgets/project_selection.dart';
import 'package:smart_task/features/task/presentation/bloc/task_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/tasks_bloc.dart';
import 'package:smart_task/features/task/presentation/widgets/task_group.dart';
import 'package:smart_task/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

class TasksRootWidget extends StatefulWidget {
  const TasksRootWidget({super.key});

  @override
  State<TasksRootWidget> createState() => _TasksRootWidgetState();
}

class _TasksRootWidgetState extends State<TasksRootWidget> {
  final List<TaskStatusEnum> items = TaskStatusEnum.values;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController(viewportFraction: .95);

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: serviceLocator<ProjectBloc>()..add(GetCurrentProjectEvent()),
          listener: (_, ProjectState state) {
            if (state is CurrentProjectChanged) {
              if (state.currentProject == null) return;
              serviceLocator<TasksBloc>()
                  .add(GetActiveTasksEvent(state.currentProject!.id));
              serviceLocator<TasksBloc>()
                  .add(GetCompletedTasksEvent(state.currentProject!.id));
            }
          },
        ),
        BlocListener(
          bloc: serviceLocator<TaskTrackingBloc>(),
          listener: (_, TaskTrackingState state) {
            if (state is TaskTrackingDurationState) {
              serviceLocator<TaskBloc>().add(UpdateTaskEvent(
                  id: state.task.id, duration: state.duration.inMinutes));
            }
          },
        ),
        BlocListener(
          bloc: serviceLocator<TaskBloc>(),
          listener: (_, TaskState state) {
            if (state is UpdateTaskSuccess) {
              serviceLocator<TasksBloc>().add(GetActiveTasksEvent(
                  serviceLocator<ProjectBloc>().state.currentProject!.id));
            }
            if (state is CreateTaskSuccess) {
              serviceLocator<TasksBloc>().add(AddNewTasksEvent(state.task));
              serviceLocator<TasksBloc>().add(GetActiveTasksEvent(
                  serviceLocator<ProjectBloc>().state.currentProject!.id));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: SmartTaskAppBar(
          elevation: .3,
          appBarHeight: 80.h,
          titleWidget: ProjectSelectionWidget(),
          trailing: BlocBuilder(
            bloc: serviceLocator<SettingsBloc>(),
            builder: (_, SettingsState state) {
              ThemeMode themeMode = state.themeMode;

              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<String>(
                    elevation: 1,
                    color: context.theme.scaffoldBackgroundColor,
                    shadowColor: context.theme.colorScheme.primary,
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.language_rounded,
                          color: context.theme.colorScheme.primary),
                    ),
                    itemBuilder: (_) => [
                      ...S.delegate.supportedLocales.map(
                        (item) {
                          return PopupMenuItem<String>(
                            height: 40.h,
                            onTap: () {
                              serviceLocator<SettingsBloc>()
                                  .add(ChangeLocalEvent(item));
                            },
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(item.languageCode.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.theme.textTheme.headlineSmall),
                          );
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      serviceLocator<SettingsBloc>().add(
                          themeMode == ThemeMode.light
                              ? DarkThemeEvent()
                              : LightThemeEvent());
                    },
                    icon: Icon(
                        themeMode == ThemeMode.light
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        color: context.theme.colorScheme.primary),
                  ),
                ],
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: BlocConsumer(
            bloc: serviceLocator<TasksBloc>(),
            listener: (context, TasksState state) {
              if (state is TasksError) {
                NotificationMessenger.showError(context, state.message);
              }
            },
            builder: (context, TasksState state) {
              return SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: items.map((item) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: item.index == 0 ? 0.w : 4.w,
                          right: item.index < items.length - 1 ? 4.w : 0.w),
                      child: TaskGroupWidget(
                          key: Key(item.name),
                          taskStatus: item,
                          tasks: state.tasks[item]?.toList(),
                          parentScrollController: _scrollController),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
