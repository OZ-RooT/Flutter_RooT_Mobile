import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:root_mobile/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:root_mobile/shared/styles/colors.dart';
import 'package:root_mobile/presentation/viewmodels/auth/auth_controller.dart';
import 'package:root_mobile/core/routes/app_routes.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = 0.obs;
    final AuthController authController = Get.put(AuthController());

    final List<Widget> pages = [
      HomeUserInfo(authController: authController),
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

class HomeUserInfo extends StatefulWidget {
  final AuthController authController;
  const HomeUserInfo({super.key, required this.authController});

  @override
  State<HomeUserInfo> createState() => _HomeUserInfoState();
}

class _HomeUserInfoState extends State<HomeUserInfo> {
  bool _triedRefresh = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_triedRefresh && widget.authController.user.value == null) {
      _triedRefresh = true;
      widget.authController.refreshCurrentUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        final user = widget.authController.user.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null)
              Text('이름: ${user.name}', style: TextStyle(fontSize: 20)),
            if (user == null)
              Text('로그인 정보를 불러올 수 없습니다.', style: TextStyle(fontSize: 16)),
            if (user != null) ...[
              Text('이메일: ${user.email}', style: TextStyle(fontSize: 16)),
              Text('평점: ${user.rating}', style: TextStyle(fontSize: 16)),
            ],
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await widget.authController.logout();
                Get.offAllNamed(AppRoutes.login);
              },
              child: Text('로그아웃'),
            ),
          ],
        );
      }),
    );
  }
}
