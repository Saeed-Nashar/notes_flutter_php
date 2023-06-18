import 'package:flutter/material.dart';
import 'package:noteapp_php/app/component/creat_red_update_detet.dart';
import 'package:noteapp_php/app/component/valid.dart';
import 'package:noteapp_php/app/constant/api_link.dart';
import 'package:noteapp_php/main.dart';

import '../component/customtextfield.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with CRUD {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey <FormState> formstate = GlobalKey<FormState>();
  bool isloading = false;

  EditNotes() async {
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postResponse(LinkNoteEdit, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
      });
      isloading = false;
      if (response['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print('error');
      }
    }
  }

  @override
  void initState() {
    title.text=widget.notes['notes_title'];
    content.text= widget.notes['notes_content'];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(251, 251, 216, 98),
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title:const Text("Edit notes"),
      ),
      body:isloading==true?Center(child: CircularProgressIndicator(color: Colors.black,),): Container(
        padding:const EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: ListView(
            children: [
              CustomTextField(valid: (String? val)=>ValidInput(val!, 60, 1, false), hint_Text: 'title', textEditingController: title,),
              CustomTextField(hint_Text: 'content', textEditingController: content, valid: (val)=>ValidInput(val!, 200, 2,false)),
              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.orange[400],
                onPressed: () async {
                  await EditNotes();
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(
                      color: Colors.white, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
