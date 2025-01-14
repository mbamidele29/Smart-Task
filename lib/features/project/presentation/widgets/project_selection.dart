import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/widgets/projects_dropdown.dart';
import 'package:smart_task/generated/l10n.dart';

class ProjectSelectionWidget extends StatelessWidget {
  final String? title;
  const ProjectSelectionWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    serviceLocator<ProjectBloc>().add(GetCurrentProjectEvent());

    return BlocBuilder(
      bloc: serviceLocator<ProjectBloc>(),
      builder: (context, ProjectState state) {
        ProjectEntity? project = state.currentProject;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(title!,
                    style: context.theme.textTheme.headlineSmall
                        ?.copyWith(fontSize: 12.sp)),
              ),
            Row(
              children: [
                Flexible(
                    child: Text(project?.name ?? S.current.noProjectSelected,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.theme.textTheme.headlineLarge)),
                10.horizontalSpace,
                ProjectsDropdownWidget(),
              ],
            ),
          ],
        );
      },
    );
  }
}
