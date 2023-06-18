import 'package:flutter/material.dart';
import 'package:noteapp_php/app/component/creat_red_update_detet.dart';
import 'package:noteapp_php/app/constant/api_link.dart';

import '../component/customtextfield.dart';
import '../component/valid.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  CRUD _crud = CRUD();
  bool isLoading = false;


  signUpApi() async {
    if(formState.currentState!.validate()){
      isLoading = true;
      setState(() {});
      var response = await _crud.postResponse(LinkSighnUp, {
        "username": usernameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        print("Sign Up error");
      }
    }else{
      print("gdgdgd");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 255,222,89),
      //Color.fromARGB(251, 251, 216, 98),
      body: isLoading == true
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
                          Image.asset("assets/home2.png",width: 200,height: 250,),
                          CustomTextField(
                            hint_Text: 'user name',
                            textEditingController: usernameController,
                            valid: (String? val ) {
                              return ValidInput(val!,50,3,false);
                            },
                          ),
                          CustomTextField(

                            hint_Text: 'email',
                            textEditingController: emailController,
                            valid: (String? val) {
                              return ValidInput(val!,40,5,true);
                            },
                          ),
                          CustomTextField(

                            hint_Text: 'password',
                            textEditingController: passwordController,
                            valid: (String? val ) {
                              return ValidInput(val!,50,7,false);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 20, bottom: 0),
                            child: Container(
                              width: 250,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.orange[400],
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  await signUpApi();
                                },
                                child: const Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        margin:const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'if have an account',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/login");
              },
              child: const Text(
                'LogIn',
                style: TextStyle(color: Colors.white, fontSize: 19),
              )),
        ]),
      ),
    );
  }
}
