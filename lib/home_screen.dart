import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_db/boxes/boxes.dart';
import 'package:hive_local_db/notes_model.dart';
import 'package:hive_local_db/widgets/show_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('Notes App',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (ctx, box, _) {
            final data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return ShowDialog(
                                      notesModel: data[index], isEdit: true);
                                });
                          },
                          icon: const Icon(Icons.edit)),
                      title: Text(data[index].title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500)),
                      subtitle: Text(data[index].description),
                      trailing: IconButton(
                          onPressed: () => data[index].delete(),
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return const ShowDialog();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
