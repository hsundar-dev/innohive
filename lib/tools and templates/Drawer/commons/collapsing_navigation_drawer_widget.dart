import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:innohive/tools%20and%20templates/Preferences.dart';
import '../custom_navigation_drawer.dart';

// ignore: must_be_immutable
class CollapsingNavigationDrawer extends StatefulWidget {
  late int currentSelectedIndex;

  CollapsingNavigationDrawer({super.key, required this.currentSelectedIndex});

  @override
  CollapsingNavigationDrawerState createState() {
    return CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxHeight = double.infinity;
  double minHeight = 80;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> heightAnimation;
  late int currentSelectedIndex = widget.currentSelectedIndex;
  bool Selected = false;

  String LoginUser = "";

  bool isDarkMode = false;
  void _loadDarkModeState() async {
    bool darkModeEnabled = await DarkModePreferences.isDarkModeEnabled();
    setState(() {
      isDarkMode = darkModeEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    Myprefs.init();
    _loadDarkModeState();
    Myprefs.getPref("LoginUser").then((value) {
      setState(() {
        LoginUser = value;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    heightAnimation = Tween<double>(
      begin: minHeight,
      end: maxHeight,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();

    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: heightAnimation.value - 10,
          width: width > 480 ? 200 : 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isCollapsed ? Colors.black.withOpacity(0.2) : Colors.transparent,
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: isCollapsed ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.cyanAccent.withOpacity(0.2),
                Colors.white.withOpacity(0.2),
              ],
            ) : const LinearGradient(colors: [Colors.transparent,Colors.transparent])
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCollapsed ? Colors.white.withOpacity(0.2) : Colors.transparent,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: isCollapsed ? ImageFilter.blur(sigmaX: 10, sigmaY: 10) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: isCollapsed ? Colors.white.withOpacity(0.1) : Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                            isCollapsed
                                ? _animationController.forward()
                                : _animationController.reverse();
                          });
                        },
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: AnimatedIcon(
                              icon: AnimatedIcons.menu_arrow,
                              progress: _animationController,
                              color: selectedColor,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Expanded(
                      flex: 0,
                      child: Center(child:
                      CircleAvatar(
                        radius: 30,
                      )),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, counter) {
                          return const SizedBox(height: 12.0);
                        },
                        itemBuilder: (context, counter) {
                          return CollapsingListTile(
                            onTap: () {
                              setState(() {
                                currentSelectedIndex = counter;
                                Selected = currentSelectedIndex == counter;
                              });
                            },
                            isSelected: currentSelectedIndex == counter,
                            title: navigationItems[counter].title,
                            icon: navigationItems[counter].icon,
                            animationController: _animationController,
                          );
                        },
                        itemCount: navigationItems.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
