import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/db/database_service.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key,this.note});
  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final DatabaseService databaseservice = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Catatan" : "Tambah Catatan",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "Jangan biarkan kosong, harus diisi..!!!";
                    }
                    return null;
                  },
                ),
                TextFormField(
                controller: _descController,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukan Text",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )
                ),
                validator: (value) {
                  if (value == "") {
                    return "Tetap harus diisi, jangan kosong..!!!";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // add note
            Note note = Note(
              _titleController.text,
              _descController.text,
              DateTime.now(),
            );
            if (widget.note != null) {
              await databaseservice.editNote(widget.note!.key, note);
              GoRouter.of(context).pop();
            } else {
              await databaseservice.addNote(note);
              GoRouter.of(context).pop();
            }
          }
        },
        label: const Text("Simpan"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
