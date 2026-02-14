import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../tools and templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  bool isDarkMode = false;
  void _loadDarkModeState() async {
    bool darkModeEnabled = await DarkModePreferences.isDarkModeEnabled();
    setState(() {
      isDarkMode = darkModeEnabled;
    });
  }

  @override
  void initState() {
    _loadDarkModeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();
    var height = media.height.toInt();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mytheme,
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: isDarkMode
                            ? AppGradients.secondaryGradient
                            : AppGradients
                                .primaryGradient, // Use the global gradient
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          height: height.toDouble() - 20,
                          width: width.toDouble() - 75,
                          child: Center(
                            child: ListView(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text("Forum"),
                                    ),
                                    Center(
                                        child: Lottie.asset(
                                      "assets/site_under_construction.json",
                                      height: height.toDouble() - 20,
                                      width: width.toDouble() - 75,
                                    )),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                    CollapsingNavigationDrawer(currentSelectedIndex: 2),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
