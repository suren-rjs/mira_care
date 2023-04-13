import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';
import 'package:mira_care/resources/service/journal_notes_service.dart';

class NotesController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<String> messages = [
    'Beth did not have a good night\'s sleep and woke up several times during the night. She ate her breakfast however it took a bit longer than normal because she appeared tired.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Picture of Beth when she came home from school',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
  ];

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
