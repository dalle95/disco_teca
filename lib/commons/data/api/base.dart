import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class BaseRepository {
  // Gestione log
  Logger logger = Logger();

  // Definizione credenziali utente
  final user = FirebaseAuth.instance.currentUser;

  // // Variabile per gestire l'ambiente
  // String get _pathPrefix => '$environment.';

  // // Collection per gli utenti
  // String get usersPath => '${_pathPrefix}users';

  @protected
  Future<DocumentSnapshot> getDocumentSnapshot(
    DocumentReference reference,
  ) async {
    logger.d('getDocumentSnapshot(${reference.path})');

    DocumentSnapshot snapshot;

    // if (isInTransaction) {
    //   snapshot = await currentTransaction!.get(reference);

    //   markSnapshotInTransaction(snapshot);
    // } else {
    snapshot = await reference.get();
    // }

    return snapshot;
  }

  @protected
  Future<DocumentSnapshot> getDocumentSnapshotByID(
    CollectionReference collectionReference,
    String id,
  ) async {
    logger.d('getDocumentSnapshotByID(${collectionReference.path}, $id)');

    DocumentSnapshot document;
    // if (isInTransaction) {
    //   snapshot = await currentTransaction!.get(reference);

    //   markSnapshotInTransaction(snapshot);
    // } else {
    document = await collectionReference.doc(id).get();
    // }

    return document;
  }

  @protected
  Future<DocumentReference> addDocumentSnapshot(
    CollectionReference collectionReference,
    Map<String, dynamic> data,
  ) async {
    logger.d('addDocumentSnapshot(${collectionReference.path}, $data)');

    DocumentReference document;
    // if (isInTransaction) {
    //   snapshot = await currentTransaction!.get(reference);

    //   markSnapshotInTransaction(snapshot);
    // } else {
    document = await collectionReference.add(data);
    // }

    return document;
  }

  Future<void> setDocumentSnapshot(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) async {
    logger.d('setDocumentSnapshot(${reference.path}, $data)');

    // if (isInTransaction) {
    //   unmarkSnapshotInTransaction(reference);

    //   currentTransaction!.set(reference, data);
    // } else {
    await reference.set(data);
    // }
  }

  Future<void> updateDocumentSnapshot(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) async {
    logger.d('updateDocumentSnapshot(${reference.path}, $data)');

    // if (isInTransaction) {
    //   unmarkSnapshotInTransaction(reference);

    //   currentTransaction!.update(reference, data);
    // } else {
    await reference.update(data);
    // }
  }

  Future<void> deleteDocumentSnapshot(
    DocumentReference reference,
  ) async {
    logger.d('deleteDocumentSnapshot(${reference.path})');

    // if (isInTransaction) {
    //   unmarkSnapshotInTransaction(reference);

    //   currentTransaction!.delete(reference);
    // } else {
    await reference.delete();
    // }
  }
}
