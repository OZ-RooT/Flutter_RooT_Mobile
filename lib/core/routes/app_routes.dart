import 'package:get/get.dart';
import 'package:root_mobile/presentation/views/main_page.dart';
import 'package:root_mobile/presentation/views/auth/login_view.dart';
import 'package:root_mobile/presentation/views/auth/signup_view.dart' hide SignupView;

class AppRoutes {
  static const String main = '/';
  static const String login = '/login';
  static const String signup = '/signup';

  static List<GetPage> routes = [
    GetPage(
      name: main,
      page: () => const MainPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signup,
      page: () => SignupView(),
      transition: Transition.fadeIn,
    ),
  ];
}
