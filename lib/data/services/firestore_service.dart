import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neuro_pairs/domain/utils/app_logger.dart';

final class FireStoreService {
  final String collectionName;

  FireStoreService(this.collectionName) {
    _initializeCollectionReference();
  }

  late final CollectionReference _collectionReference;

  Stream<List<Map<String, dynamic>>> connectCollectionSnapshots() async* {
    final snapshotsStream = _collectionReference.snapshots();

    await for (final snapshot in snapshotsStream) {
      final docsJson = snapshot.docs.map(
        (doc) => doc.data()! as Map<String, dynamic>,
      );

      yield docsJson.toList();
    }
  }

  Future<bool> containsDocByValue({
    required String field,
    required String value,
  }) async {
    try {
      final snapshots =
          await _collectionReference.where(field, isEqualTo: value).get();

      return snapshots.docs.isNotEmpty;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Undefined status',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<bool> containsDoc({required String docId}) async {
    try {
      final doc = await _collectionReference.doc(docId).get();

      return doc.exists;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Undefined status',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  Future<List<Map<String, Map<String, dynamic>>>> fetchAll() async {
    final docs = await _collectionReference.get();

    return docs.docs
        .map((e) => {e.id: e.data()! as Map<String, dynamic>})
        .toList();
  }

  Future<List<Map<String, dynamic>>> queryArrayContains({
    required String fieldName,
    required List<Object> queries,
  }) async {
    try {
      final querySnapshot =
          await _collectionReference.where(fieldName, whereIn: queries).get();

      return querySnapshot.docs
          .map((e) => e.data()! as Map<String, dynamic>)
          .toList();
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc creating finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
  }

  Future<Map<String, dynamic>?> fetchDoc({required String docId}) async {
    try {
      final doc = await _collectionReference.doc(docId).get();

      return doc.data() as Map<String, dynamic>?;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc creating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> createDoc({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _collectionReference.doc(docId).set(data);
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc creating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateDoc({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _collectionReference.doc(docId).update(data);
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc updating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deleteDoc({
    required String docId,
  }) async {
    try {
      await _collectionReference.doc(docId).delete();
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc deleting finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateField({
    required String docId,
    required String fieldName,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _collectionReference.doc(docId).set(data);
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Field updating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateFields({
    required String docId,
    required List<FireStoreField> fields,
  }) async {
    try {
      final data = <String, dynamic>{};

      for (final field in fields) {
        data[field.fieldName] =
            field.isArray ? FieldValue.arrayUnion([field.data]) : field.data;
      }

      await _collectionReference.doc(docId).set(data, SetOptions(merge: true));
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Fields updating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateArray({
    required String docId,
    required String fieldName,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _collectionReference.doc(docId).set(
        {
          fieldName: FieldValue.arrayUnion([data]),
        },
        SetOptions(merge: true),
      );
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Array updating finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<int> docsLength() async {
    try {
      final docs = await _collectionReference.get();

      return docs.size;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Doc deleting finished with error',
        error: e,
        stackTrace: stackTrace,
      );

      return -1;
    }
  }

  void _initializeCollectionReference() {
    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );

      _collectionReference = FirebaseFirestore.instance.collection(
        collectionName,
      );
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Collection reference initialization finished with error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

class _SnapshotsTransformer
    implements StreamTransformer<QuerySnapshot, List<Map<String, dynamic>>> {
  @override
  Stream<List<Map<String, dynamic>>> bind(Stream<QuerySnapshot> stream) {
    return stream.map(
      (querySnapshot) {
        return querySnapshot.docs
            .map((doc) => doc.data()! as Map<String, dynamic>)
            .toList();
      },
    );
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

final class FireStoreField {
  final String fieldName;
  final bool isArray;
  final Map<String, dynamic> data;

  const FireStoreField({
    required this.fieldName,
    required this.data,
    this.isArray = false,
  });
}
