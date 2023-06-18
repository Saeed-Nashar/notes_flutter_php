import 'package:flutter/material.dart';
import 'package:noteapp_php/app/model/note_model.dart';
class CardNotes extends StatelessWidget {
  const CardNotes({Key? key, required this.onTap, this.onpress, required this.noteModel}) : super(key: key);
final void  Function()? onTap;
  final void  Function()? onpress;

  final NoteModel noteModel;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Color.fromARGB(255, 255,222,89),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex:1,
                child: Image.asset("assets/home2.png",width: 80,height: 100,),
            ),
            Expanded(
              flex: 4,
              child: ListTile(title:  Text("${noteModel.notesTitle}",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("${noteModel.notesContent}",style: TextStyle(fontSize:20),),
              ),
            ),
            IconButton(onPressed: onTap, icon: Icon(Icons.edit),),
            IconButton(onPressed: onpress, icon: Icon(Icons.delete),),
          ],
        ),
      ),
    );
  }
}
