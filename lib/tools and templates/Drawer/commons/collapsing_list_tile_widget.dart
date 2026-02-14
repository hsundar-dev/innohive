import 'package:innohive/pages/forum.dart';
import 'package:innohive/pages/dashboard.dart';
import 'package:innohive/pages/feeds.dart';
import 'package:innohive/pages/hirer.dart';
import 'package:innohive/pages/leaderboard.dart';
import 'package:innohive/pages/projects.dart';
import 'package:innohive/pages/settings.dart';
import 'package:innohive/pages/chats.dart';
import '../../theme.dart';
import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';


// Add a constant for the special title
const String toggleDrawerTitle = "Toggle Drawer";

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  const CollapsingListTile({super.key, 
    required this.title,
    required this.icon,
    required this.animationController,
    required this.isSelected,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, heightAnimation, sizedBoxAnimation;
  late bool isCollapsed;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 70, end: 200).animate(widget.animationController);
    heightAnimation =
        Tween<double>(begin: 70, end: 200).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 0, end: 10).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var width = media.width.toInt();

    return InkWell(
      onTap: () {
        if (widget.title == toggleDrawerTitle) {
          setState(() {
            isCollapsed = !isCollapsed;
            isCollapsed
                ? _animationController.forward()
                : _animationController.reverse();
          });
        } else {
          if(widget.title == "Dashboard") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Dashboard();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Leaderboard") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Leaderboard();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Forum") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Forum();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Chats") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Chats();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Projects") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Projects();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Hirer") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Hirer();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Feeds") {
            Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const Feeds();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // No animation, just return the child as-is
                return child;
              },
            ),);
          }
          if(widget.title == "Settings") {
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
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width:  100,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : Colors.black45,
              size: 25.0,
            ),
            const SizedBox(width: 10),
            width > 414 ? Text(widget.title,style: const TextStyle(color: Colors.white),) : const SizedBox(width: 0,height: 0),
          ],
        ),
      ),
    );
  }
}


