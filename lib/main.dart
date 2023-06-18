import 'package:flutter/material.dart';
import 'package:noteapp_php/app/auth/signup.dart';
import 'package:noteapp_php/app/home.dart';
import 'package:noteapp_php/app/notes/addnotes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth/login.dart';


late SharedPreferences prefs;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs =await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute:prefs.getString('id')==null? "/login":'/home',
      routes: {
        "/login":(context)=>const LogIn(),
        "/signup":(context)=>const SignUp(),
        "/home":(context)=>const Home(),
        "/addnote":(context)=> const AddNotes(),
      },
    );
  }
}
