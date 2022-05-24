import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> navBarItems = [
  BottomNavigationBarItem(
      icon: Image.asset('assets/nav_bar_icons/tasks.png'), label: 'Tasks'),
  BottomNavigationBarItem(
      icon: Image.asset('assets/nav_bar_icons/menu.png'), label: 'Menu'),
  BottomNavigationBarItem(
      icon: Image.asset('assets/nav_bar_icons/empty.png'), label: ''),
  BottomNavigationBarItem(
      icon: Image.asset('assets/nav_bar_icons/quick.png'), label: 'Quick'),
  BottomNavigationBarItem(
      icon: Image.asset('assets/nav_bar_icons/profile.png'), label: 'Profile')
];
