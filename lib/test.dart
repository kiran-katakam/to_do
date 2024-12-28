import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool isExpanded1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              isExpanded1 = isExpanded; // Toggle the expansion state
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return const ListTile(
                  title: Text(
                    "Something",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              body: const Placeholder(),
              isExpanded: isExpanded1,
            ),
          ],
        ),
      ),
    );
  }
}
