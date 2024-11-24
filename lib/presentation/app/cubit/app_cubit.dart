import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/interactors/app/app_interactor.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppInteractor _appInteractor;

  AppCubit(this._appInteractor) : super(AppState()) {
    _initApp();
  }

  StreamSubscription<bool>? _authStateSubscription;

  void _initApp() {
    _subscribeAuthState();
  }

  Future<void> _unsubscribeAuthState() async {
    await _authStateSubscription?.cancel();
    _authStateSubscription = null;
  }

  Future<void> _subscribeAuthState() async {
    await _unsubscribeAuthState();

    _authStateSubscription = _appInteractor.authStateStream.listen(
      _onNewAuthState,
    );
  }

  void _onNewAuthState(bool wasAuthenticated) {
    if (!wasAuthenticated) {
      _appInteractor.clearSavedUserUid();
      AppRouter.navigationInstance.replaceAll(const [AuthRoute()]);
    } else {
      _appInteractor.fetchUser();
    }
  }
}
