import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/core/widgets/shimmer.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/pages/create_project.dart';
import 'package:smart_task/generated/l10n.dart';

class DropdownListWidget extends StatelessWidget {
  final VoidCallback dismiss;
  const DropdownListWidget({super.key, required this.dismiss});

  @override
  Widget build(BuildContext context) {
    List<ProjectEntity>? projects;
    serviceLocator<ProjectBloc>().add(GetProjectsEvent(false));

    return BlocBuilder(
      bloc: serviceLocator<ProjectBloc>(),
      builder: (_, state) {
        if (state is GetProjectsSuccess) {
          projects = state.projects;
        }

        if (projects != null && projects!.isEmpty) {
          FocusScope.of(context).unfocus();
          showCreateProjectWidget(context);
        }

        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: dismiss,
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 1.sw,
              height: 1.sh,
              alignment: Alignment.topCenter,
              color: Colors.black.withAlpha(100),
              child: Container(
                constraints: BoxConstraints(maxHeight: 610.h),
                decoration: const BoxDecoration(color: Colors.white),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ClampingScrollPhysics(),
                  itemCount: projects == null ? 3 : (projects!.length + 1),
                  itemBuilder: (_, index) {
                    if (projects != null && index == projects!.length) {
                      return _ItemWidget(
                        project: null,
                        isCreate: true,
                        onTap: () {
                          dismiss();
                          showCreateProjectWidget(context);
                        },
                      );
                    }

                    return _ItemWidget(
                      project: projects == null ? null : projects![index],
                      onTap: () {
                        dismiss();
                        if (projects != null) {
                          serviceLocator<ProjectBloc>()
                              .add(SetCurrentProjectEvent(projects![index]));
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final bool isCreate;
  final VoidCallback? onTap;
  final ProjectEntity? project;
  const _ItemWidget({required this.project, this.isCreate = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: project == null && !isCreate ? null : onTap,
      contentPadding: EdgeInsets.symmetric(
          horizontal: project == null && !isCreate ? 0 : 10.w),
      minVerticalPadding: 16.h,
      title: Visibility(
        visible: project == null && !isCreate,
        replacement: Text(
            isCreate ? S.current.createNewProject : project?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.headlineSmall),
        child: ShimmerWidget(width: 200.w, height: 35.sp),
      ),
    );
  }
}
