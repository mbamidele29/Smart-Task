import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_task/core/config/config.dart';
import 'package:smart_task/core/data/source/local/storage.dart';
import 'package:smart_task/core/data/source/network/http_service.dart';
import 'package:smart_task/core/data/source/network/interceptor.dart';
import 'package:smart_task/core/data/source/network/status.dart';
import 'package:smart_task/core/push_notification/local_push_notification_service.dart';
import 'package:smart_task/core/push_notification/push_notification_service.dart';
import 'package:smart_task/features/project/domain/di/di.dart';
import 'package:smart_task/features/task/domain/di/di.dart';
import 'package:smart_task/features/settings/domain/di/di.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> registerServicesDI() async {
  const String token = String.fromEnvironment("token");
  const String baseUrl = String.fromEnvironment("baseUrl");

  AppConfig.token = token;
  AppConfig.baseUrl = baseUrl;
  final LocalStorage storage = LocalStorage(
      // secureStorage: FlutterSecureStorage(),
      sharedPreferences: (await SharedPreferences.getInstance()));

  serviceLocator.registerLazySingleton(() => HttpService(
      Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
        ..interceptors.add(HttpServiceInterceptor())));
  serviceLocator
      .registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl());
  serviceLocator.registerLazySingleton<LocalStorage>(() => storage);

  PushNotificationService pushNotificationService =
      LocalPushNotificationService();
  await pushNotificationService.init();
  serviceLocator.registerLazySingleton<PushNotificationService>(
      () => pushNotificationService);

  registerTaskDI(serviceLocator);
  registerProjectDI(serviceLocator);
  registerSettingsDI(serviceLocator);
}
