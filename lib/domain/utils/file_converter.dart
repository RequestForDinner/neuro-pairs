import 'dart:io';
import 'dart:typed_data';

import 'package:neuro_pairs/domain/utils/app_logger.dart';
import 'package:neuro_pairs/domain/utils/uid_generator.dart';
import 'package:path_provider/path_provider.dart' as path;

final class FileConverter {
  Future<File?> fileFromData(
    Uint8List fileData, [
    FileExtensions? extension,
  ]) async {
    try {
      final temporaryDir = await path.getTemporaryDirectory();

      final fileExt = extension?.name ?? '';

      final temporaryFile = await File(
        '${temporaryDir.path}/${generateUid()}.$fileExt',
      ).create();

      await temporaryFile.writeAsBytes([]);
      await temporaryFile.writeAsBytes(fileData);

      return temporaryFile;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'File converting finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      return null;
    }
  }
}

enum FileExtensions { png, jpg, jpeg, webm, svg, txt }
