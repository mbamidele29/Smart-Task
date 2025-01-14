import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint("BLOC ERROR: ${error.toString()}");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("BLOC CURRENT: ${change.currentState.toString()}");
    debugPrint("BLOC NEXT: ${change.nextState.toString()}");
    super.onChange(bloc, change);
  }
}
