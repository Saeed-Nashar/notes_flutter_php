import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp_php/app/component/creat_red_update_detet.dart';
import 'package:noteapp_php/app/component/valid.dart';
import 'package:noteapp_php/app/constant/api_link.dart';
import 'package:noteapp_php/main.dart';

import '../component/customtextfield.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with CRUD {
  File? myFile;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey <FormState> formstate = GlobalKey<FormState>();
  bool isloading = false;

  AddNotes() async {
    if(myFile==null)return AwesomeDialog(context: context,title: 'important',body:const Text("please enter image"))..show();
    if (formstate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postRequestWithFile(LinkNoteAdd, {
        "title": title.text,
        "content": content.text,
        "id": prefs.getString('id'),
      },
      myFile!
      );
      isloading = false;
      if (response['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print('error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(251, 251, 216, 98),
      appBar: AppBar(
          backgroundColor: Colors.orange[400],
          title:const Text("Add notes"),
    ),
    body:isloading==true?const  Center(child: CircularProgressIndicator(color: Colors.black,),): Container(
    padding:const EdgeInsets.all(10),
    child: Form(
    key: formstate,
    child: ListView(
    children: [
      CustomTextField(valid: (String? val)=>ValidInput(val!, 60, 1, false), hint_Text: 'title', textEditingController: title,),
      CustomTextField(hint_Text: 'content', textEditingController: content, valid: (val)=>ValidInput(val!, 200, 2,false)),
     const SizedBox(height: 10,),
      MaterialButton(
        color: Colors.orange[400],
        onPressed: () async {
           showModalBottomSheet(context: context, builder: (builder)=>Container(
             width: double.infinity,
               color:  Color.fromARGB(251, 251, 216, 98),
             height: 140,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(
                   margin:EdgeInsets.only(left: 30,right: 30),
                     child:MaterialButton(
                     color: Colors.orange[400],
                     onPressed: () async {
                       XFile? xfile= await ImagePicker().pickImage(source: ImageSource.gallery);
                       myFile=File(xfile!.path);
                       },
                     child:  Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[
                         Icon(Icons.home_filled,color: Colors.white,),
                         SizedBox(width: 8,),
                         Text("Gallery",style: TextStyle(color: Colors.white,fontSize: 22),),
                       ],
                      /* style: TextStyle(
                           color: Colors.white, fontSize: 24),*/
                     ),
                   ),
                 ),
                 Container(
                   margin:EdgeInsets.only(left: 30,right: 30),
                   child:MaterialButton(
                     color: Colors.orange[400],
                     onPressed: () async {
                       XFile? xfile= await ImagePicker().pickImage(source: ImageSource.camera);
                       myFile=File(xfile!.path);
                     },
                     child:  Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:[
                         Icon(Icons.camera_alt,color: Colors.white,),
                         SizedBox(width: 8,),
                         Text("Gamera",style: TextStyle(color: Colors.white,fontSize: 22),),
                       ],
                       /* style: TextStyle(
                           color: Colors.white, fontSize: 24),*/
                     ),
                   ),
                 ),
               ],
             ),
           ));
          },
        child: const Text(
          "insert image",
          style: TextStyle(
              color: Colors.white, fontSize: 24),
        ),
      ),
      SizedBox(height: 10,),
      MaterialButton(
        color: Colors.orange[400],
        onPressed: () async {
          await AddNotes();
        },
        child: const Text(
          "Add",
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
