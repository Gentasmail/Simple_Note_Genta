import 'package:hive/hive.dart';
import '../models/note.dart';

class DatabaseService {
  static const boxName = "Notes";
  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    box.add(note);
  }

  Future<List<Note>> getNote(Note note) async {
    final box = await Hive.openBox(boxName);
    return box.get(note.key).toList().cast<Note>();
  }

  Future<void> editNote(int key, Note note) async {
    final box = await Hive.openBox(boxName);
    box.put(note.key, note);
  }

  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox(boxName);
    box.delete(note.key);
  }
}
