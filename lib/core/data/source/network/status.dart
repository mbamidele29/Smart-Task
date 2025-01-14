import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
}

class NetworkStatusImpl extends NetworkStatus {
  @override
  Future<bool> get isConnected async =>
      await InternetConnectionChecker.instance.hasConnection;
}
