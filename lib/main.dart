import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/missionView.dart';
import 'pages/aboutView.dart';
import 'pages/social.dart';
import 'backend/sheetsRequest.dart';
import 'backend/my_flutter_app_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momci Space Agency',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);
  static bool downloadingData = true;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    //MissionView.firstTime = 1;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MainView.downloadingData) {
      _refresh();
      return Scaffold(
          appBar: AppBar(
            title: const Text('Momci Space Program'),
          ),
          body: LoadingScreen());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Momci Space Program'),
      ),
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              MissionView(),
              About(),
              Social(),
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.rocket),
            title: Text('Missions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('Social')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[500],
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _refresh() {
    print("STARTED REFRESH");
    return fetchJsonList().then((_missions) {
      print("ENDED REFRESH");
      MainView.downloadingData = false;

      //precache all images
      /*
      for (int i = 0; i < _missions.length; i++) {
        String badgeUrl = _missions[i].badgeUrl;
        print("precached $badgeUrl");
        if (badgeUrl != '') precacheImage(NetworkImage(badgeUrl), context);
      }*/
      setState(() => MissionView.globalMissions = _missions);
    });
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(),
      SizedBox(height: 20),
      Text("Posodabljam informacije")
    ]));
  }
}
