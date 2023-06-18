import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
   CustomTextField({required this.hint_Text, required this.textEditingController, required this.valid,});
  final TextEditingController textEditingController;
  final  String? hint_Text;
  final String? Function(String?) valid;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(

        validator: valid,
        controller: textEditingController,
        cursorColor:Colors.white,
        decoration:   InputDecoration(
          focusedBorder:const  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ) ,
          fillColor: Colors.white,
          hintStyle:const  TextStyle(color: Colors.black,fontSize: 17),
          hintText: hint_Text,
          border:const  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }
}
