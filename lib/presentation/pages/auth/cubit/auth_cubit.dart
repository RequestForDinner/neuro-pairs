import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/interactors/auth/auth_interactor.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthInteractor _authInteractor;

  AuthCubit(this._authInteractor) : super(const AuthState());

  Future<void> signInWithGoogle() async {
    try {
      updateLoadingVisibility(needShowLoading: true);

      await _authInteractor.signInWithGoogle();

      AppRouter.navigationInstance.replaceAll(const [MainRoute()]);
    } on Object catch (_) {
      updateLoadingVisibility(needShowLoading: false);
      updateAuthErrorVisibility(needShow: true);
    }
  }

  void updateAuthErrorVisibility({bool? needShow}) {
    emit(
      state.copyWith(needShowAuthError: needShow ?? !state.needShowAuthError),
    );
  }

  void updateLoadingVisibility({bool? needShowLoading}) {
    emit(
      state.copyWith(
        needShowLoading: needShowLoading ?? !state.needShowLoading,
      ),
    );
  }
}
