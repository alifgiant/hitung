import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _defaultNote = 'Catatan Utama';
  final SharedPreferences _sharedPreferences;

  const Storage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  static late final Storage i;

  /// save note name to storage
  Future<bool> saveNoteName(String noteName) async {
    final savedNotes = getNoteNames();
    final notes = savedNotes;
    notes.add(noteName);

    return _sharedPreferences.setStringList('notes', notes);
  }

  /// get note names from storage
  List<String> getNoteNames() {
    final savedNotes = _sharedPreferences.getStringList('notes');
    if (savedNotes == null) return [_defaultNote];
    if (savedNotes.isEmpty) return [_defaultNote];
    return savedNotes;
  }

  /// select default note
  Future<bool> selectDefaultNote(String noteName) async {
    return _sharedPreferences.setString('selected-notes', noteName);
  }

  /// get default note name
  /// if not exist, return first note name
  String getDefaultNote() {
    final savedSelectedNote = _sharedPreferences.getString('selected-notes');
    if (savedSelectedNote != null) return savedSelectedNote;

    final savedNotes = getNoteNames();
    if (savedNotes.isNotEmpty) return savedNotes.first;

    return _defaultNote;
  }

  /// save note content to storage
  Future<bool> saveNoteContent(String noteName, String content) async {
    return _sharedPreferences.setString('note:$noteName', content);
  }

  /// get note content to storage
  String getNoteContent(String noteName) {
    return _sharedPreferences.getString('note:$noteName') ?? '';
  }

  Future<void> deleteNote(String noteName) async {
    final savedNotes = getNoteNames()..remove(noteName);

    await Future.wait([
      _sharedPreferences.setStringList('notes', savedNotes),
      _sharedPreferences.remove('note:$noteName'),
      if (noteName == getDefaultNote())
        _sharedPreferences.remove('selected-notes'),
    ]);
  }

  bool isInitialLoad() {
    return !_sharedPreferences.containsKey('note:$_defaultNote');
  }
}
