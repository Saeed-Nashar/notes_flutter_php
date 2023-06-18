import 'package:flutter/material.dart';
import 'package:noteapp_php/app/component/cardnotes.dart';
import 'package:noteapp_php/app/component/creat_red_update_detet.dart';
import 'package:noteapp_php/app/constant/api_link.dart';
import 'package:noteapp_php/app/model/note_model.dart';
import 'package:noteapp_php/app/notes/edit.dart';
import 'package:noteapp_php/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with CRUD {
  getNotes() async {
    var response =
        await postResponse(LinkNoteView, {'id': prefs.getString('id')});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 251, 216, 98),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Note"),
        actions: [
          IconButton(
              onPressed: () {
                prefs.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                        child: Text(
                          "There is not note",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data']!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            onpress: () async {
                              var response =
                                  await postResponse(LinkNotedelete, {
                                'id': snapshot.data['data'][i]['notes_id']
                                    .toString(),
                              });
                              if (response['status'] == 'success') {
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              } else {
                                print('error in delete');
                              }
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => EditNotes(
                                            notes: snapshot.data['data'][i],
                                          )));
                            },
                            noteModel:
                                NoteModel.fromJson(snapshot.data['data'][i]),
                          );
                        });
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.red,
                  ));
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.pushNamed(context, '/addnote');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
