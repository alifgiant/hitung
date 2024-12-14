import 'package:flutter/material.dart';
import 'package:hitung/src/core/storage.dart';

class NoteProvider extends ChangeNotifier {
  final Storage _storage;

  NoteProvider({
    Storage? storage,
  }) : _storage = storage ?? Storage.i;

  List<String> noteNames = <String>[];
  String selectedNote = '';

  void initState() {
    noteNames = _storage.getNoteNames();
    selectedNote = _storage.getDefaultNote();
    notifyListeners();
  }

  String getNoteContent(String noteName) {
    return _storage.getNoteContent(noteName);
  }

  Future<bool> saveNoteContent(String noteName, String content) {
    return _storage.saveNoteContent(noteName, content);
  }

  Future<void> deleteNote(String noteName) async {
    await _storage.deleteNote(noteName);
    initState();
  }

  Future<bool> createNote(String noteName) async {
    await _storage.saveNoteName(noteName);
    noteNames.add(noteName);
    notifyListeners();
    return selectNote(noteName);
  }

  Future<bool> selectNote(String noteName) async {
    selectedNote = noteName;
    notifyListeners();
    return _storage.selectDefaultNote(noteName);
  }
}
