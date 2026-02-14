import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import 'package:innohive/tools%20and%20templates/glass%20_morphism_tile.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';
import '../tools and templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadDarkModeState();
  }

  void _loadDarkModeState() async {
    bool darkModeEnabled = await DarkModePreferences.isDarkModeEnabled();
    setState(() {
      isDarkMode = darkModeEnabled;
    });
  }

  void _toggleDarkMode(bool value) async {
    setState(() {
      isDarkMode = value;
      print(value);
    });
    await DarkModePreferences.setDarkModeEnabled(value);
  }

  void _showDeveloperPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AboutDeveloper(); // Your custom popup content
      },
    );
  }

  void _showAppPopup(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context){
      return const AboutApp();
    }
    );
  }

  void _showSupportPopup(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return const Support();
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      themeMode: ThemeMode.dark,
      home: Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: isDarkMode ? AppGradients.secondaryGradient : AppGradients.primaryGradient, // Use the global gradient
                  ),
                ),
                Center(
                    child: SizedBox(
                        height: height.toDouble() - 20,
                        width: width.toDouble() - 75,
                        child: Center(
                          child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                crossAxisAlignment: CrossAxisAlignment
                                    .center,
                                children: [
                                  GlassTile(
                                      height: 50,
                                      width: 300,
                                      radius: 10,
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            isDarkMode ? 'Dark Mode Enabled' : 'Dark Mode Disabled',
                                            style: TextStyle(
                                                color: isDarkMode ? Colors.white : Colors.black
                                            ),
                                          ),
                                          Switch(
                                            value: isDarkMode,
                                            activeColor: Colors.grey,
                                            activeTrackColor: Colors.black,
                                            onChanged: _toggleDarkMode,
                                            thumbIcon: WidgetStateProperty.resolveWith ((Set  states) {
                                              if(states.contains(WidgetState.selected)) {
                                                return const Icon(Icons.dark_mode,color: Colors.white);
                                              }
                                              else {
                                                return const Icon(Icons.light_mode,color: Colors.black);
                                              }
                                              // All other states will use the default thumbIcon.
                                            }),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     Myprefs.delPref("isDarkMode");
                                  //   },
                                  //   child: GlassTile(
                                  //       height: 50,
                                  //       width: 300,
                                  //       radius: 10,
                                  //       content: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //         children: [
                                  //           Text("Delete"),
                                  //           Icon(Icons.delete)
                                  //         ],
                                  //       )),
                                  // ),
                                  // Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      _showDeveloperPopup(context);
                                    },
                                    child: GlassTile(
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("About Developer ",style: TextStyle(
                                            color: isDarkMode ? Colors.white : Colors.black,
                                          ),),
                                          Text("</>",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode ? Colors.white : Colors.black,
                                          ),)
                                        ],
                                      ),
                                      width: 300,
                                      height: 50,
                                      radius: 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      _showAppPopup(context);
                                    },
                                    child: GlassTile(
                                        height: 50,
                                        width: 300,
                                        radius: 10,
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("About Application ",style: TextStyle(
                                              color: isDarkMode ? Colors.white : Colors.black,
                                            ),),
                                            Icon(Icons.apps_rounded,color: isDarkMode ? Colors.white : Colors.black)
                                          ],
                                        ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Icon(Icons.logout,color: isDarkMode ? Colors.white : Colors.black),
                                          content: Text('Do you want Logout',style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Myprefs.delPref("LoginUser");
                                                FirebaseAuth.instance.signOut();
                                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Lander()));
                                              },
                                              child: const Text('YES'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return const Settings();
                                                    },
                                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                      // No animation, just return the child as-is
                                                      return child;
                                                    },
                                                  ),);
                                              },
                                              child: const Text('NO'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: GlassTile(
                                        height: 50,
                                        width: 300,
                                        radius: 10,
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Logout",style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                                            const SizedBox(width: 10),
                                            Icon(Icons.logout,color: isDarkMode ? Colors.white : Colors.black)
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //     _showSupportPopup(context);
                                  //   },
                                  //   child: GlassTile(
                                  //     height: 50,
                                  //     width: 300,
                                  //     radius: 10,
                                  //     content: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       crossAxisAlignment: CrossAxisAlignment.center,
                                  //       children: [
                                  //         const Text("Support "),
                                  //         Container(
                                  //           height: 30,
                                  //           width: 30,
                                  //           decoration: const BoxDecoration(
                                  //             shape: BoxShape.circle,
                                  //           ),
                                  //           child: const Icon(Icons.support),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                          ),
                        )
                    )
                ),
                CollapsingNavigationDrawer(currentSelectedIndex: 7),
              ],
            ),
          );
        }
      ),
    );
  }
}

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      ),
      title: const Text('About Developer'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/avatar.png",),
                ),
              ),
            ),
            const Divider(),
            Text("Name: HEMASUNDAR "
                ".U",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
            Text("Gmail: spideysundar2004@gmail.com",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.w))
            ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();

    return AlertDialog(
      backgroundColor: popupColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      ),
      title: const Text('About App'),
      content: SingleChildScrollView(
        child: ListBody(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/innohive.png",),
                  ),
                ),
              ),
              const Divider(),
              Text("Name: innohive",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
              const Divider(),
              Text("Version: 1.0.0.0",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
              const Divider(),
              Text("Language: Dart by Google",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
              const Divider(),
              Text("Framework: Flutter by Google",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
              const Divider(),
              Text("Backend: Python's FastAPI",style: TextStyle(fontSize: width > 480 ? 1.5.w : 3.5.w)),
              const Divider(),
              GestureDetector(
                child: const GlassTile(
                    height: 30,
                    width: 10,
                    radius: 10,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Terms And Conditions"),
                        Icon(Icons.download)
                      ],
                    )
                ),
              ),
              const Divider(),
            ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      ),
      title: const Text('Support'),
      content: SingleChildScrollView(
        child: ListBody(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.support),
              ),
              const Divider(),

            ]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

