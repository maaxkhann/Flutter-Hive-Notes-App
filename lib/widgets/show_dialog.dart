import 'package:flutter/material.dart';
import 'package:hive_local_db/boxes/boxes.dart';
import 'package:hive_local_db/notes_model.dart';

class ShowDialog extends StatefulWidget {
  final NotesModel? notesModel;

  final bool? isEdit;
  const ShowDialog({super.key, this.notesModel, this.isEdit = false});

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isEdit == true) {
      titleController.text = widget.notesModel?.title ?? '';
      descriptionController.text = widget.notesModel?.description ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit == false ? 'Add Note' : 'Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title')),
          const SizedBox(height: 10),
          TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: 'Description')),
        ],
      ),
      actions: [
        widget.isEdit == false
            ? TextButton(
                onPressed: () {
                  final data = NotesModel(
                      title: titleController.text,
                      description: descriptionController.text);
                  final box = Boxes.getData();
                  box.add(data);
                  Navigator.pop(context);
                  titleController.clear();
                  descriptionController.clear();
                },
                child: const Text('Add'))
            : TextButton(
                onPressed: () {
                  widget.notesModel?.title = titleController.text;
                  widget.notesModel?.description = descriptionController.text;
                  widget.notesModel?.save();
                  Navigator.pop(context);
                  titleController.clear();
                  descriptionController.clear();
                },
                child: const Text('Update')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
            },
            child: const Text('Cancel'))
      ],
    );
  }
}
