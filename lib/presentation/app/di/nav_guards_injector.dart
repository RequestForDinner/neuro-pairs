import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/app/navigation/guards/auth_guard.dart';

void injectNavigationGuards() {
  Injector.instance.injectFactory<AuthGuard>(
    () => AuthGuard(
      Injector.instance.instanceOf<IAuthPreferencesRepository>(),
    ),
  );
}
