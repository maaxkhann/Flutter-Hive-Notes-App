import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_db/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('Notes');
}
