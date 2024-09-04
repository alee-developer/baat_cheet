import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        letIndexChange: (index) {
          return true;
        },
        key: _bottomNavigationKey,
        items: const [
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: manageScreens(_page),
    );
  }

  Widget manageScreens(int index) {
    return index == 0
        ? Container(
            child: Text("Add Screen"),
          )
        : index == 1
            ? Container(
                child: Text("Menu Screen"),
              )
            : Container(
                child: Text("Share screen"
                    ""),
              );
  }
}
