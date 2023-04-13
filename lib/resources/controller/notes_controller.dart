import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';
import 'package:mira_care/resources/service/journal_notes_service.dart';

class NotesController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  List<Note> _journalNotes = [];

  @override
  void onInit() {
    super.onInit();
    _journalNotes.clear();
    getJournalNotes();
  }

  getJournalNotes() async {
    _journalNotes.clear();
    await journalNotesService.get().then((value) {
      _journalNotes = value;
      update();
    }).onError((error, stackTrace) {
      _journalNotes.clear();
      update();
    });
  }

  newJournalNote(Note note) async {
    await journalNotesService.add(note);
    getJournalNotes();
  }

  updateById(Note note) async {
    await journalNotesService.update(note);
    getJournalNotes();
  }

  delete(String id) async {
    await journalNotesService.delete(id);
    getJournalNotes();
  }

  List<Note> get notes => _journalNotes;

  int get notesTotal => notes.length;
}
