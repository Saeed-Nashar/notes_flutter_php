import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp_php/app/component/creat_red_update_detet.dart';
import 'package:noteapp_php/app/home.dart';
import 'package:noteapp_php/main.dart';

import '../component/customtextfield.dart';
import '../component/valid.dart';
import '../constant/api_link.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  CRUD _crud = CRUD();
  bool isloading = false;

  logInApi() async {
    if (formState.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await _crud.postResponse(LinkLogIn, {
        "email": emailController.text,
        "password": passwordController.text,
      });
      isloading = false;
      setState(() {});
      if (response['status'] == 'success') {
        prefs.setString('id', response['data']['id'].toString());
        prefs.setString('email',response['data']['email']);
        prefs.setString('username', response['data']['username']);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            body:  Text(
                "The email or password is incorrect, or the account does not exist"))..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(251, 251, 216, 98),
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Container(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    child: Form(
                      key: formState,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/note10.png",
                            width: 500,
                          ),
                          CustomTextField(
                            hint_Text: 'email',
                            textEditingController: emailController,
                            valid: (String? val) {
                              return ValidInput(val!, 40, 4, true);
                            },
                          ),
                          CustomTextField(
                            hint_Text: 'password',
                            textEditingController: passwordController,
                            valid: (String? val) {
                              return ValidInput(val!, 50, 7, false);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              color: Colors.orange[400],
                              onPressed: () async {
                                await logInApi();
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Row(children: [
                              const Text('if have not account'),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/signup");
                                  },
                                  child: const Text(
                                    'signup',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
