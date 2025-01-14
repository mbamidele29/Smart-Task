import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_task/core/navigation/go_router.dart';
import 'package:smart_task/core/utils/bloc_observer.dart';
import 'package:smart_task/core/utils/themes/theme.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerServicesDI();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return BlocBuilder(
          bloc: serviceLocator<SettingsBloc>()..add(GetSettingsEvent()),
          builder: (_, SettingsState state) {
            Locale locale = state.locale;
            ThemeMode themeMode = state.themeMode;

            return MaterialApp.router(
              title: 'Smart Task',
              debugShowCheckedModeBanner: false,
              locale: locale, // Locale('de'),
              localizationsDelegates: const [
                S.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              routerConfig: goRouter,
            );
          },
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      serviceLocator<TaskTrackingBloc>().add(SaveAllTrackingEvent());
    }
    super.didChangeAppLifecycleState(state);
  }
}
