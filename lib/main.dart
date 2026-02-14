import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:innohive/firebase_options.dart';
import 'package:innohive/pages/dashboard.dart';
import 'package:innohive/pages/login.dart';
import 'package:innohive/services/auth_services.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter binding first
    await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      Sizer(
        builder: (context, orientation, deviceType) {
          return ChangeNotifierProvider(
            create: (context) => AuthServices(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: mytheme,
                home: const Lander()
            ),
          );
        },
      ),
    );
  }

class Lander extends StatefulWidget {
  const Lander({super.key});

  @override
  State<Lander> createState() => _LanderState();
}

class _LanderState extends State<Lander> {
  List<Color> colors = [Colors.blue, Colors.purple, Colors.red, Colors.green]; // List of gradient colors
  int currentIndex = 0;

  void changeGradientColor() {
    setState(() {
      currentIndex = (currentIndex + 1) % colors.length;
    });
  }

  void checkLogin(){
    Myprefs.getPref("LoginUser").then((value){
      if(value == "NULL"){
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Login()));
      }
      else {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Dashboard()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Myprefs.init();
    // Create a timer to change the gradient color every 2 seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {
      changeGradientColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var height = media.height;
    var width = media.width;
    return Scaffold(
      body: AnimatedContainer(duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors[currentIndex],
              colors[(currentIndex + 1) % colors.length]
            ],
          ),
        ),
        child: SizedBox(
            height: height.toDouble() + 20,
            width: width.toDouble(),
            child: Stack(
                alignment: Alignment.topCenter,
                children: [ SizedBox(
                  height: height.toDouble(),
                  width: width.toDouble(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: const BoxDecoration(

                            ),
                            child: Image.asset("assets/innohive.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text("INNOHIVE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: width > 480 ? 5.w : 12.w,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 10, right: 10),
                          child: Text(
                            "Welcome to the world of Students and projects!"
                            , style: TextStyle(
                            fontSize: width > 480 ? 3.w : 7.5.w,
                            color: Colors.white54,
                          ), textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: SizedBox(
                            height: 5.h,
                            width: width > 480 ? 10.w : 30.w,
                            child: FloatingActionButton(
                              elevation: 15,
                              onPressed: () {
                                checkLogin();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  Text("Let's GO ",
                                    style: TextStyle(
                                      fontSize: width > 480 ? 1.w : 3.w,
                                      color: Colors.white,
                                    ), textAlign: TextAlign.center,),
                                  Icon(Icons.arrow_forward_ios,
                                    size: width > 480 ? 1.w : 3.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 100))
                      ],
                    ),
                  ),
                ),
                  Positioned(
                      bottom: 2.h,
                      left: (width / 2) - 90,
                      child: SizedBox(
                          child: Image.asset(
                            "assets/footer.png", scale: 3,)))
                ]
            )
        ),
      ),
    );
  }
}


