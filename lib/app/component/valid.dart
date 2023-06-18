import 'package:flutter/material.dart';
import 'package:noteapp_php/app/constant/message.dart';

ValidInput( String val, int max , int min, bool emailBoll){
  if(val.length>max){
    return "$messageInputMax $max";
  }

  if(val.isEmpty){
    return "$messageInputEpty";
  }
  if(val.length<min){
    return "$messageInputMin $min";
  }

  if(emailBoll==true){
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(val)) {
      return ("Please Enter a valid email");
    }
  }
}