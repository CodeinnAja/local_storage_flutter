import 'package:flutter/material.dart';
import 'package:flutter_local_storage_notes_app/pages/detail_page.dart';
import 'package:flutter_local_storage_notes_app/pages/from_pages.dart';
import 'package:flutter_local_storage_notes_app/utils/database.dart';
import 'package:flutter_local_storage_notes_app/widget/card_widget.dart';
import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//membuat List
  List<Note> notes = [
    Note(
      id: 1,
      title: 'Bensin',
      descripsi: 'isi bensi habis 50k',
      time: DateTime.now(),
    ),
    Note(
      id: 2,
      title: 'Bensin',
      descripsi: 'isi bensi habis 50k',
      time: DateTime.now(),
    ),
    Note(
      id: 3,
      title: 'Bensin',
      descripsi: 'isi bensi habis 50k',
      time: DateTime.now(),
    ),
  ];
  bool isLoading = false; //variavel mendefinisikan refresh halaman
  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });
    notes = await DatabaseNote.instance.readAll();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DatabaseNote.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page Note Apps"),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return InkWell(
                    //ini di asyn await agar data update an refresh
                    onTap: () async {
                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DetailPage(note: notes[index]);
                      }));
                      refreshNote();
                    },
                    child: CardWIdget(
                      index: index,
                      notes: notes[index],
                    ),
                  );
                },
                itemCount: notes.length,
              ),
            ),
      //pada floating ini navigaotor ditambahi asyn await terus refreshNote()
      // agar data muncul di halaman
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return FromPage();
          }));
          refreshNote();
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
