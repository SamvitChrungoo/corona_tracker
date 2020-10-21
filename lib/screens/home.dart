import 'package:corona_tracker/screens/about.dart';
import 'package:corona_tracker/screens/cases.dart';
import 'package:corona_tracker/screens/homepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> tabs = [HomePage(), Cases(), About()];

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNav(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Covid Data Tracker"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.grey[300],
        body: tabs[currIndex]);
  }

  Widget bottomNav() {
    return BottomNavigationBar(
        iconSize: 28,
        currentIndex: currIndex,
        backgroundColor: Colors.green,
        onTap: (int index) {
          setState(() {
            currIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currIndex == 0 ? Colors.white : Colors.green[900],
              ),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: currIndex == 1 ? Colors.white : Colors.green[900],
            ),
            label: "Cases",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: currIndex == 2 ? Colors.white : Colors.green[900],
            ),
            label: "Dashboard",
          ),
        ]);
  }
}
