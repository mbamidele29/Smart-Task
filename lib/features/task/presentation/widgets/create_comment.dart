import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/utils/notification_message.dart';
import 'package:smart_task/core/utils/validator.dart';
import 'package:smart_task/core/widgets/app_textfield.dart';
import 'package:smart_task/core/widgets/button.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/presentation/bloc/task_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

showCreateCommentWidget(BuildContext context, TaskEntity task) async {
  OverlayEntry? overlayEntry;
  OverlayState? overlayState = Overlay.of(context);

  dismiss() {
    if (overlayEntry?.mounted == true) {
      overlayEntry?.remove();
    }
  }

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: _CreateCommentWidget(task: task, onDismiss: dismiss),
    ),
  );

  overlayState.insert(overlayEntry);
}

class _CreateCommentWidget extends StatefulWidget {
  final TaskEntity task;
  final VoidCallback onDismiss;

  const _CreateCommentWidget({required this.task, required this.onDismiss});

  @override
  State<_CreateCommentWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<_CreateCommentWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;
  final TextEditingController _textController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(_controller);
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return BlocConsumer(
      bloc: serviceLocator<TaskBloc>(),
      listener: (_, TaskState state) {
        if (state is CreateTaskCommentLoading) {}
        if (state is CreateTaskCommentError) {
          NotificationMessenger.showError(context, state.message);
        }
        if (state is CreateTaskCommentSuccess) {
          _dismiss();
        }
      },
      builder: (_, state) {
        if (state is CreateTaskCommentLoading) {
          isLoading = true;
        }
        if (state is CreateTaskCommentError) {
          isLoading = false;
        }
        if (state is CreateTaskCommentSuccess) {
          isLoading = false;
        }
        return IgnorePointer(
          ignoring: isLoading,
          child: GestureDetector(
            onTap: _dismiss,
            child: Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.topCenter,
              color: Colors.black.withAlpha(100),
              child: SlideTransition(
                position: _animation,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 20.h),
                    color: context.theme.scaffoldBackgroundColor,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediaQuery.of(context).viewPadding.top.verticalSpace,
                          Text(S.current.addComment,
                              style: context.theme.textTheme.headlineMedium),
                          20.verticalSpace,
                          AppTextFieldWidget(
                            autoFocus: true,
                            controller: _textController,
                            headerText: S.current.comment,
                            validator: Validator.requiredValidator,
                          ),
                          AppButtonWidget(
                            isLoading: isLoading,
                            text: S.current.create,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                serviceLocator<TaskBloc>().add(
                                    CreateTaskCommentEvent(
                                        taskId: widget.task.id,
                                        comment: _textController.text.trim()));
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }
}
