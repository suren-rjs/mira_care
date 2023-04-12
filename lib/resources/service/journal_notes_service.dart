import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';

JournalNotesService journalNotesService = JournalNotesService.instance;

class JournalNotesService {
  JournalNotesService._();

  static final JournalNotesService instance = JournalNotesService._();

  final _tasks = FirebaseFirestore.instance.collection("JournalNotes");

  Future<List<Note>> get() async {
    List<Note>? list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _tasks.orderBy("dateTime", descending: false).get();
    list = querySnapshot.docs
        .map((e) => Note.fromMap(e.data(), e.id))
        .cast<Note>()
        .toList();
    return list;
  }

  Future<bool> add(Note note) async {
    return await _tasks.add(note.toMap()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> update(Note note) async {
    return await _tasks.doc(note.id).update(note.toMap()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> delete(String id) async {
    return await _tasks.doc(id).delete().then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
