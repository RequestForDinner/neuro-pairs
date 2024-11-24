part of 'profile_edit_cubit.dart';

final class ProfileEditState {
  final User? currentUser;
  final User? userForChanging;

  final bool needLoading;

  const ProfileEditState({
    this.currentUser,
    this.userForChanging,
    this.needLoading = false,
  });

  ProfileEditState copyWith({
    User? currentUser,
    User? userForChanging,
    bool? needLoading,
  }) {
    return ProfileEditState(
      currentUser: currentUser ?? this.currentUser,
      userForChanging: userForChanging ?? this.userForChanging,
      needLoading: needLoading ?? this.needLoading,
    );
  }
}
