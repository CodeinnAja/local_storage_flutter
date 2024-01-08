import 'package:flutter/material.dart';
import 'package:flutter_local_storage_notes_app/pages/from_pages.dart';
import 'package:flutter_local_storage_notes_app/utils/database.dart';
import '../models/note_model.dart';

class DetailPage extends StatefulWidget {
  final Note note;
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
//ini dalah parameter refreshNote
  late Note note;

  Future refreshNote() async {
    note = await DatabaseNote.instance.readNote(widget.note.id!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    note = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Colors.blue,
        actions: [
          InkWell(
            //ketika melakukan edit agar data berubah harus pake asyn await
            onTap: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return FromPage(
                  note: widget.note,
                );
              }));
              //ini refreshNote agar data terifrash dan berubah sesuai editan
              refreshNote();
            },
            child: Icon(Icons.edit_note),
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
              onTap: () async {
                await DatabaseNote.instance.delete(widget.note.id!);
                Navigator.of(context).pop();
              },
              child: Icon(Icons.delete)),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              note.descripsi,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
