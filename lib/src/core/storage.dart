import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences _sharedPreferences;

  const Storage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  /// save note name to storage
  Future<bool> saveNoteName(String noteName) async {
    final savedNotes = getNoteNames();
    final notes = savedNotes ?? List.empty(growable: true);
    notes.add(noteName);

    return _sharedPreferences.setStringList('notes', notes);
  }

  /// get note names from storage
  List<String>? getNoteNames() => _sharedPreferences.getStringList('notes');

  /// select default note
  Future<bool> selectDefaultNote(String noteName) async {
    return _sharedPreferences.setString('selected-notes', noteName);
  }

  /// get default note name
  /// if not exist, return first note name
  String getDefaultNote() {
    final savedSelectedNote = _sharedPreferences.getString('selected-notes');
    if (savedSelectedNote != null) return savedSelectedNote;

    final savedNotes = getNoteNames() ?? [];
    if (savedNotes.isNotEmpty) return savedNotes.first;

    return 'Catatan Utama';
  }

  /// save note content to storage
  Future<bool> saveNoteContent(String noteName, String content) async {
    return _sharedPreferences.setString('note:$noteName', content);
  }

  /// get note content to storage
  String getNoteContent(String noteName) {
    return _sharedPreferences.getString('note:$noteName') ?? '';
  }
}
