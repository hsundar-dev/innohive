import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/theme.dart';
import 'package:lottie/lottie.dart';
import '../tools and templates/Drawer/commons/collapsing_navigation_drawer_widget.dart';

class Hirer extends StatefulWidget {
  const Hirer({super.key});

  @override
  State<Hirer> createState() => _HirerState();
}

class _HirerState extends State<Hirer> {
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
    // TODO: implement initState
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
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: isDarkMode ? AppGradients.secondaryGradient : AppGradients.primaryGradient, // Use the global gradient
              ),
            ),
            Positioned(
              top: 10,
              left: 70,
              child: Center(
                child: SizedBox(
                    height: height.toDouble() - 20,
                    width: width.toDouble() - 75,
                    child: Center(
                      child: ListView(
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Hirers"),
                              ),
                            ],
                          ),
                          Center(
                              child: Lottie.asset(
                                "assets/site_under_construction.json",
                                height: height.toDouble() - 20,
                                width: width.toDouble() - 75,
                              )
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
            CollapsingNavigationDrawer(currentSelectedIndex: 4),
          ],
        ),
      ),
    );
  }
}
