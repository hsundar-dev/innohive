import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationModel({required this.title, required this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Dashboard", icon: Icons.dashboard),
  NavigationModel(title: "Leaderboard", icon: Icons.bar_chart),
  NavigationModel(title: "Forum", icon: Icons.forum),
  NavigationModel(title: "Chats", icon: Icons.people),
  NavigationModel(title: "Hirer", icon: Icons.approval),
  NavigationModel(title: "Projects", icon: Icons.rocket_launch),
  NavigationModel(title: "Feeds", icon: Icons.feed),
  NavigationModel(title: "Settings", icon: Icons.settings),
];