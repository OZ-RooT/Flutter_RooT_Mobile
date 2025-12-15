import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_mobile/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:root_mobile/shared/styles/colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = 0.obs;
    
    final List<Widget> pages = [
      Container(),
      // TODO: Add more pages as needed
    ];

    ThemeColors colors = ThemeColors.of(context); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.gray50,
        toolbarHeight: 18,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: colors.gray50,
      extendBody: true,
      body: Obx(() => pages[currentIndex.value]),
      bottomNavigationBar: Obx(() => MyBottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
        },
      )),
    );
  }
}
