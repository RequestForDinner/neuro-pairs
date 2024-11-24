import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:neuro_pairs/domain/utils/app_logger.dart';
import 'package:neuro_pairs/domain/utils/file_converter.dart';

final class StorageService {
  final _storageInstance = FirebaseStorage.instance;

  Future<String> uploadImageBytes({
    required String directory,
    required Uint8List imageBytes,
  }) async {
    try {
      await _storageInstance.ref(directory).putData(imageBytes);

      return _storageInstance.ref(directory).getDownloadURL();
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Uploading file to $directory finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<void> deleteFile({required String directory}) async {
    try {
      await _storageInstance.ref(directory).delete();
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Deleting file to $directory finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<String> fetchConcreteFileUrl({
    required String directory,
    required String fileId,
  }) async {
    try {
      final storageRef = _storageInstance.ref('$directory/$fileId');

      return storageRef.getDownloadURL();
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Fetching file with ref: $directory/$fileId finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<Uint8List> fetchConcreteFileData({
    required String directory,
    required String fileId,
  }) async {
    try {
      final storageRef = _storageInstance.ref('$directory/$fileId');

      final fileData = await storageRef.getData();

      if (fileData == null) {
        throw const FormatException('Fetching file data finished with error');
      }

      return fileData;
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Fetching file with ref: $directory/$fileId finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<File> fetchConcreteFile({
    required String directory,
    required String fileId,
  }) async {
    try {
      final storageRef = _storageInstance.ref('$directory/$fileId');

      final fileData = await storageRef.getData();

      if (fileData == null) {
        throw const FormatException('Fetching file data finished with error');
      }

      final fileConverter = FileConverter();
      final fetchedFile = await fileConverter.fileFromData(
        fileData,
        FileExtensions.png,
      );

      if (fetchedFile == null) {
        throw const FormatException('Something went wrong');
      }

      return fetchedFile;
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Fetching file with ref: $directory/$fileId finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<String> fetchRandomFileUrl({required String directory}) async {
    try {
      final allStructure = await _storageInstance.ref('$directory/').list();

      if (allStructure.items.isEmpty) {
        throw Exception('Folder ($directory) stores zero files');
      }

      final randomRefIndex = Random().nextInt(allStructure.items.length);
      final fileRef = allStructure.items[randomRefIndex];

      return fileRef.getDownloadURL();
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Fetching file from folder: $directory finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<File> fetchRandomFile({required String directory}) async {
    try {
      final allStructure = await _storageInstance.ref('$directory/').list();

      if (allStructure.items.isEmpty) {
        throw Exception('Folder ($directory) stores zero files');
      }

      final randomRefIndex = Random().nextInt(allStructure.items.length);
      final fileRef = allStructure.items[randomRefIndex];

      final fileData = await fileRef.getData();

      if (fileData == null) {
        throw const FormatException('Something went wrong');
      }

      final fetchedFile = await FileConverter().fileFromData(
        fileData,
        FileExtensions.png,
      );

      if (fetchedFile == null) {
        throw const FormatException('Fetching file data finished with error');
      }

      return fetchedFile;
    } catch (e, stackTrace) {
      AppLogger.logError(
        'Fetching file from folder: $directory finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }
}
