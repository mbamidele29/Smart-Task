import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/notification_message.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/utils/validator.dart';
import 'package:smart_task/core/widgets/app_chipchoicefield.dart';
import 'package:smart_task/core/widgets/app_datefield.dart';
import 'package:smart_task/core/widgets/app_textfield.dart';
import 'package:smart_task/core/widgets/appbar.dart';
import 'package:smart_task/core/widgets/button.dart';
import 'package:smart_task/core/widgets/chip.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/widgets/project_selection.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

class TaskFormWidget extends StatelessWidget {
  final TaskEntity? task;
  const TaskFormWidget({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    String? title = task?.content;
    TaskPriorityEnum? priority = task?.priority;
    String? description = task?.description;
    DateTime? dueDate = task?.dueDate?.datetime;

    final GlobalKey<FormState> formKey = GlobalKey();
    // final List<TaskStatusEnum> statuses = TaskStatusEnum.values;
    final List<TaskPriorityEnum> priorities = TaskPriorityEnum.values;

    return Scaffold(
      appBar: SmartTaskAppBar(
        elevation: 1,
        appBarHeight: 80.h,
        leading: BackButton(color: context.theme.colorScheme.primary),
        titleWidget: ProjectSelectionWidget(title: S.current.newTaskFor),
      ),
      body: BlocConsumer(
        bloc: serviceLocator<TaskBloc>(),
        listener: (_, TaskState state) {
          if (state is CreateTaskLoading) {
            isLoading = true;
          }
          if (state is CreateTaskSuccess) {
            isLoading = false;
            NotificationMessenger.showSuccess(
                context, S.current.taskCreatedSuccessfully);
            context.pop();
          }
          if (state is CreateTaskError) {
            isLoading = false;
            NotificationMessenger.showError(context, state.message);
            context.pop();
          }

          ///

          if (state is UpdateTaskLoading) {
            isLoading = true;
          }
          if (state is UpdateTaskSuccess) {
            isLoading = false;
            NotificationMessenger.showSuccess(
                context, S.current.taskUpdatedSuccessfully);
            context.pop();
          }
          if (state is UpdateTaskError) {
            isLoading = false;
            NotificationMessenger.showError(context, state.message);
            context.pop();
          }
        },
        builder: (_, TaskState state) {
          return Column(
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: isLoading,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextFieldWidget(
                            initialValue: title,
                            headerText: S.current.title,
                            onSaved: (val) => title = val,
                            validator: Validator.requiredValidator,
                          ),
                          8.verticalSpace,
                          AppTextFieldWidget(
                            lines: 3,
                            initialValue: description,
                            headerText: S.current.description,
                            onSaved: (val) => description = val,
                            textInputAction: TextInputAction.newline,
                          ),
                          8.verticalSpace,
                          AppDateFieldWidget(
                            initialValue: dueDate,
                            headerText: S.current.dueDate,
                            onSaved: (val) => dueDate = val,
                          ),
                          8.verticalSpace,
                          AppChipchoicefieldWidget(
                            items: priorities,
                            initialValue: priority,
                            headerText: S.current.priority,
                            onSaved: (val) => priority = val,
                            // validator: (val) {
                            //   return Validator.requiredValidator(val?.name);
                            // },
                            builder: (item, selected) {
                              Color textColor = selected
                                  ? context.theme.colorScheme.onPrimary
                                  : item.color;

                              return AppChipWidget(
                                  name: item.name,
                                  textColor: textColor,
                                  borderColor: item.color,
                                  color: selected ? item.color : null);
                            },
                          ),
                          // 16.verticalSpace,
                          // AppChipchoicefieldWidget(
                          //   items: statuses,
                          //   initialValue: status,
                          //   headerText: S.current.status,
                          //   onSaved: (val) => status = val,
                          //   validator: (val) {
                          //     return Validator.requiredValidator(val?.name);
                          //   },
                          //   builder: (item, selected) {
                          //     Color textColor = selected
                          //         ? context.theme.colorScheme.onPrimary
                          //         : item.color;

                          //     return AppChipWidget(
                          //         name: item.name,
                          //         textColor: textColor,
                          //         borderColor: item.color,
                          //         color: selected ? item.color : null);
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                child: AppButtonWidget(
                  isLoading: isLoading,
                  text: task == null ? S.current.create : S.current.update,
                  onPressed: () {
                    if (serviceLocator<ProjectBloc>().state.currentProject ==
                        null) {
                      NotificationMessenger.showError(
                          context, S.current.pleaseSelectAProject);
                      return;
                    }
                    if (formKey.currentState?.validate() ?? false) {
                      formKey.currentState!.save();

                      if (task == null) {
                        serviceLocator<TaskBloc>().add(CreateTaskEvent(
                            title: title!,
                            dueDate: dueDate,
                            projectId: serviceLocator<ProjectBloc>()
                                .state
                                .currentProject!
                                .id,
                            priority: priority?.code,
                            description: description));
                      } else {
                        serviceLocator<TaskBloc>().add(UpdateTaskEvent(
                            labels: [],
                            title: title!,
                            dueDate: dueDate,
                            id: task!.id,
                            priority: priority?.code,
                            description: description));
                      }
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
