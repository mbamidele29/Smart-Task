import 'package:go_router/go_router.dart';
import 'package:smart_task/core/navigation/routes.dart';
import 'package:smart_task/features/task/presentation/pages/root.dart';
import 'package:smart_task/features/project/presentation/pages/root.dart';
import 'package:smart_task/features/task/presentation/pages/task_form.dart';
import 'package:smart_task/core/navigation/transitions/slide_transition.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: NavigationRoutes.project,
  routes: [
    GoRoute(
        path: NavigationRoutes.project,
        builder: (context, state) => ProjectRootWidget()),
    GoRoute(
        path: NavigationRoutes.tasks,
        builder: (context, state) => TasksRootWidget()),
    GoRoute(
        path: NavigationRoutes.createTask,
        pageBuilder: (_, state) =>
            slideInTransition(child: TaskFormWidget(), state: state)),
    GoRoute(
        path: NavigationRoutes.updateTask,
        pageBuilder: (_, state) {
          Map args = state.extra as Map;
          return slideInTransition(
              child: TaskFormWidget(task: args['task']), state: state);
        }),
  ],
);
