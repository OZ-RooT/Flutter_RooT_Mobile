import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_controller.dart';
import 'package:root_mobile/core/routes/app_routes.dart';

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
  final TextEditingController languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final locale = Get.deviceLocale?.languageCode ?? 'en';
    languageController.text = locale;
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
                decoration: InputDecoration(labelText: '비밀번호'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.signup(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          languageController.text,
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
