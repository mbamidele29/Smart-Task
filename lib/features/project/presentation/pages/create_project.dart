import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/utils/notification_message.dart';
import 'package:smart_task/core/utils/validator.dart';
import 'package:smart_task/core/widgets/app_textfield.dart';
import 'package:smart_task/core/widgets/button.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/bloc/project_form_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

showCreateProjectWidget(BuildContext context) async {
  OverlayEntry? overlayEntry;
  OverlayState? overlayState = Overlay.of(context);

  dismiss() {
    if (overlayEntry?.mounted == true) {
      overlayEntry?.remove();
    }
  }

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
        top: 0, left: 0, right: 0, child: _CreateProjectWidget(dismiss)),
  );

  overlayState.insert(overlayEntry);
}

class _CreateProjectWidget extends StatefulWidget {
  final VoidCallback onDismiss;
  const _CreateProjectWidget(this.onDismiss);

  @override
  State<_CreateProjectWidget> createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<_CreateProjectWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;
  final TextEditingController _nameController = TextEditingController();

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
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return BlocConsumer(
      bloc: serviceLocator<ProjectFormBloc>(),
      listener: (_, ProjectFormState state) {
        if (state is CreateProjectLoading) {}
        if (state is CreateProjectError) {
          NotificationMessenger.showError(context, state.message);
        }
        if (state is CreateProjectSuccess) {
          serviceLocator<ProjectBloc>().add(AddNewProjectEvent(state.project));
          _dismiss();
          NotificationMessenger.showSuccess(
              context, S.current.projectCreatedSuccessfully);
        }
      },
      builder: (_, state) {
        if (state is CreateProjectLoading) {
          isLoading = true;
        }
        if (state is CreateProjectError) {
          isLoading = false;
        }
        if (state is CreateProjectSuccess) {
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
                          Text(S.current.createNewProject,
                              style: context.theme.textTheme.headlineMedium),
                          20.verticalSpace,
                          AppTextFieldWidget(
                            autoFocus: true,
                            controller: _nameController,
                            headerText: S.current.projectName,
                            validator: Validator.requiredValidator,
                          ),
                          AppButtonWidget(
                            isLoading: isLoading,
                            text: S.current.create,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                serviceLocator<ProjectFormBloc>().add(
                                    CreateProjectEvent(
                                        _nameController.text.trim()));
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
