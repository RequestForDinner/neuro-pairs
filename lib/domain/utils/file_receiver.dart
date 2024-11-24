import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:neuro_pairs/domain/utils/app_logger.dart';

final class FileReceiver {
  Future<Uint8List?> assetFileBytes({required String assetPath}) async {
    try {
      final bytesData = await rootBundle.load(assetPath);
      final fileBytes = bytesData.buffer.asUint8List();

      return fileBytes;
    } on Object catch (e, stackTrace) {
      AppLogger.logError('Error', error: e, stackTrace: stackTrace);

      return null;
    }
  }
}
