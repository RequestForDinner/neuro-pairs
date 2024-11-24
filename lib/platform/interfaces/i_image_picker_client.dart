import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IImagePickerClient {
  Future<File?> pickImage({ImageSource? pickSource});

  Future<bool> canUploadRawImage({
    required File image,
    required int maxImageKbSize,
  });

  Future<List<PermissionStatus>> verifyPermissionStatus({
    required List<Permission> permissions,
  });

  Future<List<Permission>> permissionFromImageSource({ImageSource? source});
}
