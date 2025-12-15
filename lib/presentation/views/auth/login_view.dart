import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_controller.dart';
import 'package:root_mobile/core/routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (controller.isLoggedIn) {
      Future.microtask(() => Get.offAllNamed(AppRoutes.main));
    }
    ever(controller.token, (token) {
      if (token != null) {
        Get.offAllNamed(AppRoutes.main);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: '이메일'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          controller.login(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('로그인'),
                ),
                if (controller.loginError.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      controller.loginError.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.signup);
                  },
                  child: Text('회원가입'),
                ),
              ],
            )),
      ),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final AuthController controller = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    ever(controller.user, (user) {
      if (user != null) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: '이메일'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        final locale = Get.deviceLocale?.languageCode ?? 'en';
                        controller.signup(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          locale,
                        );
                      },
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('회원가입'),
              ),
              if (controller.signupError.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    controller.signupError.value,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.login);
                },
                child: Text('로그인으로 돌아가기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
