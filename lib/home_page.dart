import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'track.dart';

SideMenuController sideMenu = SideMenuController();

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  @override
  void initState() {
    // Connect SideMenuController and PageController together
    sideMenu.addListener((index) {
      _pageController.jumpToPage(index);
    });
    super.initState();
  }

  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            title: const SizedBox(
              height: 200,
              child: Center(
                child: Image(
                  image: AssetImage("images/logo.png"),
                  width: 80,
                  height: 80,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            items: items,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blue[200],
              selectedColor: Colors.white,
              selectedTitleTextStyle:
                  TextStyle(color: Color.fromARGB(255, 18, 170, 241)),
              selectedIconColor: Color.fromARGB(255, 18, 170, 241),
              unselectedIconColor: Colors.white70,
              unselectedTitleTextStyle: TextStyle(color: Colors.white70),
              showHamburger: false,
              openSideMenuWidth: 200,

              backgroundColor: Color.fromARGB(255, 18, 170, 241),
              // openSideMenuWidth: 200
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                TrackPage(),
                Container(
                  child: Center(
                    child: Text('Expansion Item 1'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Expansion Item 2'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<SideMenuItem> items = [
  SideMenuItem(
    title: 'Track',
    onTap: (index, _) {
      sideMenu.changePage(index);
    },
    icon: const Icon(Icons.av_timer),
  ),
  SideMenuItem(
    title: 'Analyze',
    onTap: (index, _) {
      sideMenu.changePage(index);
    },
    icon: const Icon(Icons.donut_large),
  ),  
];
