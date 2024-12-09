import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'track.dart';

SideMenuController sideMenu = SideMenuController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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

  @override
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
                  const TextStyle(color: Color.fromARGB(255, 18, 170, 241)),
              selectedIconColor: const Color.fromARGB(255, 18, 170, 241),
              unselectedIconColor: Colors.white70,
              unselectedTitleTextStyle: const TextStyle(color: Colors.white70),
              showHamburger: false,
              openSideMenuWidth: 200,

              backgroundColor: const Color.fromARGB(255, 18, 170, 241),
              // openSideMenuWidth: 200
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                TrackPage()
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
];
