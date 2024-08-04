import 'package:flutter/material.dart';
import 'package:my_app/pages/favorite_page.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:my_app/pages/setting_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pageList = [
    HomePage(),
    FavoritePage(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kungpotato'),
          leading: Image.asset('assets/images/logo.png'),
          actions: [
            GestureDetector(
              onTap: () {
                //
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/orm.jpg'),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
        body: Center(
          child: _pageList.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightGreen,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
