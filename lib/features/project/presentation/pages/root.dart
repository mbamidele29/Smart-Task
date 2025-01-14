import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/navigation/routes.dart';
import 'package:smart_task/core/values/assets.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/utils/extensions/context_ext.dart';

class ProjectRootWidget extends StatefulWidget {
  const ProjectRootWidget({super.key});

  @override
  State<ProjectRootWidget> createState() => _ProjectRootWidgetState();
}

class _ProjectRootWidgetState extends State<ProjectRootWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // AnimationController(vsync: this, duration: Duration(seconds: 2))
    //     .forward()
    //     .whenComplete(() {
    // context.go(NavigationRoutes.board);
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceLocator<ProjectBloc>().add(GetProjectsEvent(true));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: serviceLocator<ProjectBloc>(),
      listener: (_, state) {
        if (state is GetProjectsSuccess || state is GetProjectsError) {
          context.go(NavigationRoutes.tasks);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(AppAssets.welcomeLottie),
              Text(
                S.of(context).welcomeBack,
                style: context.theme.textTheme.headlineLarge
                    ?.copyWith(fontSize: 28.sp),
              ),
              24.verticalSpace,
              Text(S.current.pleaseWait,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.headlineSmall),
              50.verticalSpace,

              // SizedBox(
              //   width: 1.sw,
              //   height: 1.sh / 2,
              //   child: Stack(
              //     children: [
              // ...TaskStatusEnum.values.map((e) => AnimatingBlurWidget(
              //     multiplier: e.index % 2 == 0 ? 1 : -2, color: e.color)),
              //       BackdropFilter(
              //         filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              //         child: SizedBox(
              //           width: 1.sw,
              //           height: 1.sh,
              //           child: Column(
              //             children: [
              //               // Image.asset(AppAssets.user),
              //               LottieBuilder.asset('assets/json/welcome.json')
              //             ],
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
