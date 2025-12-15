import 'package:flutter/material.dart';
import 'package:root_mobile/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:root_mobile/shared/styles/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    
    pages = [
      // TODO: Replace with actual page widgets
      Container(),
    ];
  }

  @override
  Widget build(BuildContext context) {   
    ThemeColors colors = ThemeColors.of(context); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.gray50,
        toolbarHeight: 18,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: colors.gray50,
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}