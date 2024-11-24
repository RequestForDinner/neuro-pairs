import 'package:neuro_pairs/data/data_sources/interfaces/i_remote_auth_data_source.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/utils/typedefs.dart';

final class RemoteAuthRepository implements IRemoteAuthRepository {
  final IRemoteAuthDataSource _remoteAuthDataSource;

  const RemoteAuthRepository(this._remoteAuthDataSource);

  @override
  Stream<bool> get authStateStream => _remoteAuthDataSource.authStateStream;

  @override
  String? get userCredentialUid => _remoteAuthDataSource.userCredentialUid;

  @override
  UserDisplayCredential signInWithGoogle() {
    return _remoteAuthDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return _remoteAuthDataSource.signOut();
  }
}
