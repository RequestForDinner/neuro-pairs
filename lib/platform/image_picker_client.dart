import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:neuro_pairs/platform/app_platform.dart';
import 'package:neuro_pairs/platform/interfaces/i_image_picker_client.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerClient extends IImagePickerClient {
  @override
  Future<File?> pickImage({ImageSource? pickSource}) async {
    final rawImage = await ImagePicker().pickImage(
      source: pickSource ?? ImageSource.gallery,
    );

    if (rawImage != null) {
      final rawImagePath = rawImage.path;

      return File(rawImagePath);
    }

    return null;
  }

  @override
  Future<bool> canUploadRawImage({
    required File image,
    required int maxImageKbSize,
  }) async {
    final imageBytes = (await image.readAsBytes()).lengthInBytes;

    return imageBytes / 1024 <= maxImageKbSize;
  }

  @override
  Future<List<PermissionStatus>> verifyPermissionStatus({
    required List<Permission> permissions,
  }) async {
    final permissionStatuses = await Future.wait(
      permissions.map((permission) => permission.request()),
    );

    return permissionStatuses;
  }

  @override
  Future<List<Permission>> permissionFromImageSource({
    ImageSource? source,
  }) async {
    final Permission galleryPermission;

    if (Platform.isIOS) {
      galleryPermission = Permission.photos;
    } else {
      galleryPermission = await AppPlatform.currentAndroidSdkVersion() >= 33
          ? Permission.mediaLibrary
          : Permission.storage;
    }

    return switch (source) {
      ImageSource.gallery || null => [galleryPermission],
      ImageSource.camera => [Permission.camera],
    };
  }
}
