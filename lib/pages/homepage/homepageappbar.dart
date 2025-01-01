import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Tasks"),
      centerTitle: true,
      shadowColor: Colors.black,
      elevation: 3,
      titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white),
      // backgroundColor: Colors.purple[900],
    );
  }
}
