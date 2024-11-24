import 'package:auto_route/auto_route.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';

final class AuthGuard extends AutoRouteGuard {
  final IAuthPreferencesRepository _authPreferencesRepository;

  AuthGuard(this._authPreferencesRepository);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final savedUserUid = _authPreferencesRepository.fetchUserUid();

    if (savedUserUid == null) {
      router.replaceAll(const [AuthRoute()]);

      return;
    }

    resolver.next();
  }
}
