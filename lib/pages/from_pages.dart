import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_storage_notes_app/models/note_model.dart';
import 'package:flutter_local_storage_notes_app/utils/database.dart';

class FromPage extends StatefulWidget {
  final Note? note;
  const FromPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<FromPage> createState() => _FromPageState();
}

class _FromPageState extends State<FromPage> {
  //membuat form untuk edit dan title
  TextEditingController titleController = TextEditingController();
  TextEditingController descripsiController = TextEditingController();

//ini jika mengecek detail page ke halaman edit
  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descripsiController.text = widget.note!.descripsi;
    }
    super.initState();
  }

  //membuat function edit
  Future updateNote() async {
    final note = widget.note!.copyWith(
      title: titleController.text,
      descripsi: descripsiController.text,
    );
    await DatabaseNote.instance.update(note);
    Navigator.of(context).pop();
  }

//mewmbuat function"
  Future addNote() async {
    final note = Note(
      id: null,
      title: titleController.text,
      descripsi: descripsiController.text,
      time: DateTime.now(),
    );
    await DatabaseNote.instance.create(note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
        backgroundColor: Colors.blueAccent,
        actions: [
          InkWell(
            //ontap tadinya addNOte sekarang dibuat percabangan agar bisa edit add
            onTap: () {
              if (widget.note != null) {
                updateNote();
              } else {
                addNote();
              }
            },
            child: const Icon(Icons.save),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descripsiController,
              maxLines: 10,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Catatan ...',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
