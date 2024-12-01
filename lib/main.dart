import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

PageController pageController = PageController();
SideMenuController sideMenu = SideMenuController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('test'),
        ),
        body: Row(
          children: [
            SideMenu(
              controller: sideMenu,
              title: Text("app logo"),
              footer: Text("login image"),
              items: items,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                hoverColor: Colors.blue[200],
                selectedColor: Colors.white,
                selectedTitleTextStyle: TextStyle(color: Color.fromARGB(255, 18, 170, 241)),
                selectedIconColor: Color.fromARGB(255, 18, 170, 241),
                unselectedIconColor: Colors.white70,
                unselectedTitleTextStyle: TextStyle(color: Colors.white70),
                showHamburger: false,
                openSideMenuWidth: 200,
            
                backgroundColor: Color.fromARGB(255, 18, 170, 241),
                // openSideMenuWidth: 200
              ),
            ),
          ],
        ),
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
  SideMenuItem(
    title: 'Plan',
    onTap: (index, _) {
      sideMenu.changePage(index);
    },
    icon: const Icon(Icons.description),
  ),
  SideMenuItem(
    title: 'Log out',
    onTap: (_, __) {},
    icon: Icon(Icons.exit_to_app),
  ),
];