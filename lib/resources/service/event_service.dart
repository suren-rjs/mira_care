// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mira_care/resources/data/model/event.dart';

_EventService eventService = _EventService.instance;

class _EventService {
  _EventService._();

  static final _EventService instance = _EventService._();

  final _events = FirebaseFirestore.instance.collection("Event");

  Future<List<JournalEvent>> get() async {
    List<JournalEvent>? list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _events.orderBy("dateTime", descending: false).get();
    list = querySnapshot.docs
        .map((e) => JournalEvent.fromJson(e.data(), e.id))
        .cast<JournalEvent>()
        .toList();
    return list;
  }

  Future<bool> add(JournalEvent event) async {
    return await _events.add(event.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> update(JournalEvent event) async {
    return await _events.doc(event.id).update(event.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> delete(String id) async {
    return await _events.doc(id).delete().then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
