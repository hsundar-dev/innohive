import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:innohive/pages/dashboard.dart';
import 'package:innohive/pages/signup.dart';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import 'package:innohive/tools%20and%20templates/glass%20_morphism_tile.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
        ),
    ),
      home: Sizer(
        builder: (context, orientation, deviceType) {
          return const MyLogin();
        },
      )
          );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool passwordVisible=true;
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // ignore: non_constant_identifier_names
  bool email_error = false;
  // ignore: non_constant_identifier_names
  bool pswd_error = false;

  // ignore: non_constant_identifier_names
  void AllValidation(){
    emailValidation();
    pswdValidation();
  }

  void emailValidation(){
    if(!EmailValidator.validate(email.text) || email.text.isEmpty){
      setState(() {
        email_error = true;
      });
    }
    else{
      setState(() {
        email_error = false;
      });
    }
  }

  void pswdValidation(){
    final input = pswd.text;
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,}$');
    if(!regex.hasMatch(input) || input.isEmpty){
      setState(() {
        pswd_error = true;
      });
    }
    else{
      setState(() {
        pswd_error = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;
    var width = media.width.toInt();
    var height = media.height.toInt();

    void signin(String email,pswd) async {
      try {
        final response = await http.post(
          Uri.parse("https://fastapi03-success-gowtham2004.vercel.app/login"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "email": email,
            "pswd": pswd
          }),
        );
        // Handle the response.
        if (response.statusCode == 200) {
          var data = response.body;
          Map<String, dynamic> user = json.decode(data);
          if (user["status"] == "ok") {
            try{
              Myprefs.setPref("studcode", user["studcode"]);
              Myprefs.setPref("LoginUser", user["data"]);
              Myprefs.setPref("LoginRole", user["role"]);
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Dashboard()));
            }
            // ignore: empty_catches
            catch(e){
            }
          } else {
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: const Icon(Icons.error, color: Colors.red, size: 50),
                    content: const Text(
                        'Sorry! User Not fount Do you want to proceed with Signup'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).popUntil((route) =>
                              route.isFirst);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const Signup()));
                            },
                            child: const Text('OK'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                      secondaryAnimation) {
                                    return const Login();
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    // No animation, just return the child as-is
                                    return child;
                                  },
                                ),);
                            },
                            child: const Text('NO'),
                          ),
                        ],
                      )
                    ],
                  ),
            );
          }
        } else {
          // ignore: use_build_context_synchronously
          QuickAlert.show(context: context,
              type: QuickAlertType.warning,
              text: "Ckeck your Internet");
        }
      }
      catch(e){
        // ignore: use_build_context_synchronously
        QuickAlert.show(context: context,
            type: QuickAlertType.warning,
            text: "Ckeck your Internet");
      }
  }


    return Scaffold(
      body: GestureDetector(
        onTap: (){
          AllValidation();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover
              )
          ),
          child: Center(
            child: GlassTile(
              height: height > 480 ? 50.h : 40.h,
              width: width < 913 ? 80.w : 30.w,
              radius: 16,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height > 480 ? 5.h : 5.h,
                          width: width < 913 ? 65.w : 20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: email_error ? Colors.orange : Colors.black),
                          ),
                          child: TextField(
                            focusNode: _emailFocusNode,
                            controller: email,
                            onTap: () {
                              AllValidation();
                            },
                            decoration: const InputDecoration(
                              hintText: " Email",
                              hintStyle: TextStyle(color: Colors.white60,fontSize: 18),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                            ),
                          ),
                        ),
                        const Text(" "),
                        Visibility(
                            visible: email_error,
                            child: Tooltip(
                                message: "Email Format Incorrect check it out",
                                child: IconButton(icon: const Icon(Icons.error),color: Colors.orange, onPressed: () {
                                  QuickAlert.show(context: context, type: QuickAlertType.warning, text: "Email Format Incorrect check it out");
                                },))
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: height > 480 ? 5.h : 5.h,
                          width: width < 913 ? 65.w : 20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: pswd_error ? Colors.orange : Colors.black),
                          ),
                          child: TextField(
                            focusNode: _passwordFocusNode,
                            onTap: () {
                              AllValidation();
                            },
                            autofillHints: const <String>[],
                            enableSuggestions: false,
                            autofocus: false,
                            autocorrect: false,
                            controller: pswd,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              hintText: " Password",
                              hintStyle: const TextStyle(color: Colors.white60,fontSize: 18),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 5,left: 10),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,color: Colors.black),
                                onPressed: () {
                                  setState(
                                        () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const Text(" "),
                        Visibility(
                            visible: pswd_error,
                            child: Tooltip(
                              message: "Your Password must contain Uppercase,Lowercase,Number and Special character",
                                child: IconButton(icon: const Icon(Icons.error),color: Colors.orange, onPressed: () {
                                  QuickAlert.show(context: context, type: QuickAlertType.warning, text: "Your Password must contain an Uppercase, an Lower Case, and an Number, an Special Character");
                                },))
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height > 480 ? 5.h : 5.h,
                    width: width < 913 ? 30.w : 10.w,
                    child: FloatingActionButton(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                        onPressed: () async {
                          AllValidation();
                          if(email_error || pswd_error) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                text: "Please clear all the warnings and proceed"
                            );
                          }
                          else{
                            signin(email.text.trim(), pswd.text.trim());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Log In "),
                            Icon(Icons.login,size:width > 480 ? 1.5.w : 5.w,)
                          ],
                        )
                    ),
                  ),
                  const Text(
                    'You didn\'t have an account, Sign up here',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                      )
                  ),
                  SizedBox(
                    height: height > 480 ? 5.h : 5.h,
                    width: width < 913 ? 30.w : 10.w,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Signup()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text("Sign Up",style: TextStyle(color: Colors.white),),
                    ),

                    // child: FloatingActionButton(
                    //     backgroundColor: Colors.blue,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     onPressed: (){
                    //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signup()));
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text("Sign Up "),
                    //       ],
                    //     )
                    // ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 5,
      ),
    );
  }
}