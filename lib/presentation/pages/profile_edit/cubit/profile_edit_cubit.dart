import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_edit_interactor.dart';
import 'package:neuro_pairs/platform/interfaces/i_image_picker_client.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final ProfileEditInteractor _profileEditInteractor;
  final IImagePickerClient _imagePickerClient;

  ProfileEditCubit(this._profileEditInteractor, this._imagePickerClient)
      : super(const ProfileEditState()) {
    _initPage();
  }

  StreamSubscription<User?>? _userSubscription;

  @override
  Future<void> close() async {
    await _unsubscribeUser();

    return super.close();
  }

  void updateUsername(String username) {
    emit(
      state.copyWith(
        userForChanging: state.userForChanging?.copyWith(username: username),
      ),
    );
  }

  Future<void> saveChanges() async {
    _updateNeedLoading(needLoading: true);

    if (await _profileEditInteractor.nameAlreadyExists(
      lowerCaseName: state.userForChanging!.lowerCaseName,
    )) {
      return;
    }

    Uint8List? updatedImageBytes;
    try {
      final fileForUploadingPath = state.userForChanging?.avatarUrl;
      final fileForUploading = File(fileForUploadingPath ?? '');

      if (!await fileForUploading.exists()) {
        throw const FileSystemException('No file for uploading');
      }

      final imageBytes = await fileForUploading.readAsBytes();

      updatedImageBytes = imageBytes;
    } on Object catch (_) {
      updatedImageBytes = null;
    }

    await _profileEditInteractor.updateUser(
      updatedUser: state.userForChanging!,
      imageBytes: updatedImageBytes,
    );

    _updateNeedLoading(needLoading: false);
  }

  Future<void> uploadAvatar(ImageSource source) async {
    final permissions = await _imagePickerClient.permissionFromImageSource(
      source: source,
    );

    final permissionsStatuses = await _imagePickerClient.verifyPermissionStatus(
      permissions: permissions,
    );

    if (permissionsStatuses.contains(PermissionStatus.permanentlyDenied)) {
      return;
    }

    final pickedImage = await _imagePickerClient.pickImage(pickSource: source);
    if (pickedImage != null) {
      emit(
        state.copyWith(
          userForChanging: state.userForChanging?.copyWith(
            avatarUrl: pickedImage.path,
          ),
        ),
      );
    }
  }

  void deleteUserImage() {
    emit(
      state.copyWith(
        userForChanging: state.userForChanging?.copyWith(
          avatarUrl: null,
          needClearAvatarUrl: true,
        ),
      ),
    );
  }

  void _initPage() {
    _subscribeUser();
  }

  Future<void> _unsubscribeUser() async {
    await _userSubscription?.cancel();
    _userSubscription = null;
  }

  Future<void> _subscribeUser() async {
    await _unsubscribeUser();

    _userSubscription = _profileEditInteractor.userStream.listen(
      _onUserReceived,
    );
  }

  Future<void> _onUserReceived(User? user) async {
    if (user == null) return;

    await Future.delayed(const Duration(milliseconds: 400));

    emit(
      state.copyWith(currentUser: user, userForChanging: user),
    );
  }

  void _updateNeedLoading({bool needLoading = false}) {
    emit(
      state.copyWith(needLoading: needLoading),
    );
  }
}
