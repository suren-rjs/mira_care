// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mira_care/resources/data/model/calendar_remainder.dart';

_CalendarRemainderService remainderService = _CalendarRemainderService.instance;

class _CalendarRemainderService {
  _CalendarRemainderService._();

  static final _CalendarRemainderService instance =
      _CalendarRemainderService._();

  final _remainders =
      FirebaseFirestore.instance.collection("CalendarRemainder");

  Future<List<CalendarRemainder>> get(DateTime date) async {
    List<CalendarRemainder>? list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _remainders
        .where('remainderDate', isEqualTo: Timestamp.fromDate(date))
        .orderBy("dateTime", descending: false)
        .get();
    list = querySnapshot.docs
        .map((e) => CalendarRemainder.fromJson(e.data(), e.id))
        .cast<CalendarRemainder>()
        .toList();
    return list;
  }

  Future<bool> add(CalendarRemainder remainder) async {
    return await _remainders.add(remainder.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> update(CalendarRemainder remainder) async {
    return await _remainders
        .doc(remainder.id)
        .update(remainder.toJson())
        .then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> delete(String id) async {
    return await _remainders.doc(id).delete().then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
