import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FAB extends StatelessWidget {
  const FAB({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      foregroundColor: Colors.white,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      spacing: 10,
      buttonSize: const Size.square(60),
      childMargin: const EdgeInsets.all(20),
      activeChild: const Icon(
        Icons.close_rounded,
        size: 28,
      ),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.book),
          label: "Academic",
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

        ),
        SpeedDialChild(
          child: const Icon(Icons.person_outline_rounded),
          label: "Personal",
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ],
      child: const Icon(
        Icons.add,
        size: 28,
      ),
    );
  }
}
