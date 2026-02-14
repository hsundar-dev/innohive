import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:innohive/pages/login.dart';
import 'package:innohive/pages/dashboard.dart';
import 'package:innohive/services/auth_services.dart';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import 'package:innohive/tools%20and%20templates/glass%20_morphism_tile.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';


const List<String> list = <String>['student','hirer'];
String dropdownValue = list.first;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

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
          }
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

  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController pswd = TextEditingController();
  TextEditingController cnpswd = TextEditingController();

  final FocusNode _unameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _cnpasswordFocusNode = FocusNode();


  bool uname_error = false;
  bool email_error = false;
  bool mobile_error = false;
  bool pswd_error = false;
  bool cnpswd_error = false;

  bool passwordVisible=true;
  bool cnpasswordVisible = true;



  void AllValidation(){
    usernameValidation();
    emailValidation();
    phoneValidation();
    pswdValidation();
    cpswdValidation();
  }

  void usernameValidation(){
    final input = uname.text;
    final regex = RegExp(r'^[a-z]');
    if(!regex.hasMatch(input) || input.isEmpty){
      setState(() {
        uname_error = true;
      });
    }
    else{
      setState(() {
        uname_error = false;
      });
    }
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

  void phoneValidation(){
    final input = mobile.text;
    final regex = RegExp(r'^[0-9]+$');
    if(!regex.hasMatch(input) || input.length != 10 || input.isEmpty){
      setState(() {
        mobile_error = true;
      });
    }
    else{
      setState(() {
        mobile_error = false;
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

  void cpswdValidation(){
    if(pswd.text != cnpswd.text || cnpswd.text.isEmpty){
      setState(() {
        cnpswd_error = true;
      });
    }
    else{
      setState(() {
        cnpswd_error = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _postMessage(String uname, String email, String mobile, String pswd) async {
    late AuthServices authService = Provider.of<AuthServices>(context,listen: false);

    const url = "https://fastapi03-success-gowtham2004.vercel.app/signup";
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      "uname" : uname,
      "email" : email,
      "phone" : mobile,
      "pswd" : pswd,
      "role" : dropdownValue,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        var data = response.body;
        Map<String, dynamic> user = json.decode(data);
        if(user["status"] == "success"){
          authService.signUpWithEmailAndPassword(email, pswd);
          Myprefs.setPref("LoginUser", uname);
          Myprefs.setPref("LoginRole", dropdownValue);
          Myprefs.setPref("studcode", user["studcode"]);
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Dashboard()));
        }
        else {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Icon(Icons.error, color: Colors.red, size: 50),
                  content: Text(
                      user["message"]+', Do you want to proceed with Signin'),
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
                                builder: (_) => const Login()));
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                    secondaryAnimation) {
                                  return const Signup();
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
      }
      else {
      }
    }
    catch (error) {
    }
  }

  void firebase_up() async {
    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: email.text,
    //     password: pswd.text,
    //   );
    //   print('User registered: ${userCredential.user?.uid}');
    // }
    // catch (e) {
    //   print('Error registering user: $e');
    // }
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();

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
                height: height > 480 ? 65.h : 60.h,
                width: width < 913 ? 80.w : 30.w,
                radius: 16,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                        'Sign Up',
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
                              border: Border.all(color: uname_error ? Colors.orange : Colors.black),
                            ),
                            child: TextField(
                              maxLength: 10,
                              focusNode: _unameFocusNode,
                              controller: uname,
                              onTap: () {
                                AllValidation();
                              },
                              decoration: const InputDecoration(
                                hintText: " Username",
                                hintStyle: TextStyle(color: Colors.white60,fontSize: 18),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                              ),
                            ),
                          ),
                          const Text(" "),
                          Visibility(
                            visible: uname_error,
                              child: const Icon(Icons.error,color: Colors.orange)
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
                              child: const Icon(Icons.error,color: Colors.orange)
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
                              border: Border.all(color: mobile_error ? Colors.orange : Colors.black),
                            ),
                            child: TextField(
                              focusNode: _mobileFocusNode,
                              controller: mobile,
                              onTap: () {
                                AllValidation();
                              },
                              decoration: const InputDecoration(
                                hintText: " MobileNo",
                                hintStyle: TextStyle(color: Colors.white60,fontSize: 18),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                              ),
                            ),
                          ),
                          const Text(" "),
                          Visibility(
                              visible: mobile_error,
                              child: const Icon(Icons.error,color: Colors.orange)
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
                              child: const Icon(Icons.error,color: Colors.orange)
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
                              border: Border.all(color: cnpswd_error ? Colors.orange : Colors.black),
                            ),
                            child: TextField(
                              focusNode: _cnpasswordFocusNode,
                              onTap: () {
                                AllValidation();
                                if(pswd_error){
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.warning,
                                      text: "Password must contain atleast a UPPER_CASE and a lower_case and a number and a Special_charcter"
                                  );
                                }
                              },
                              autofillHints: const <String>[],
                              enableSuggestions: false,
                              autofocus: false,
                              autocorrect: false,
                              controller: cnpswd,
                              obscureText: passwordVisible,
                              decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: Colors.white60,fontSize: 18),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10,left: 10),
                              ),
                            ),
                          ),
                          const Text(" "),
                          Visibility(
                              visible: cnpswd_error,
                              child: const Icon(Icons.error,color: Colors.orange)
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
                          GlassTile(
                            height: height > 480 ? 5.h : 5.h,
                            width: width < 913 ? 65.w : 20.w,
                            radius: 10,
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style: const TextStyle(color: Colors.white60,fontSize: 18),
                                underline: Container(
                                  height: 0
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                  );
                                }).toList(),
                              ),
                            )
                          ),
                          const Text(" "),
                          Visibility(
                              visible: uname_error,
                              child: const Icon(Icons.error,color: Colors.orange)
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
                          onPressed: (){
                            AllValidation();
                            if(uname_error || email_error || mobile_error || pswd_error || cnpswd_error) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.warning,
                                text: "Please clear all the warnings and proceed"
                              );
                            }
                            else{
                                _postMessage(uname.text, email.text, mobile.text, pswd.text);
                            }
                            },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Sign Up"),
                            ],
                          )
                      ),
                    ),
                    const Text(
                        'You already have an account, Login here',
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Login()));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text("Log In",style: TextStyle(color: Colors.white),),
                      ),
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

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedValue = 'student'; // Set the default selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: [
        'student',
        'hirer',
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
