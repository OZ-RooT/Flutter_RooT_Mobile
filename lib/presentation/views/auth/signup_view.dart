import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/auth_controller.dart';
import 'package:root_mobile/core/routes/app_routes.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

final AuthController controller = Get.find();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _SignupViewState extends State<SignupView> {
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

  String _getDeviceLocale() {
    if (Get.deviceLocale != null) {
      return Get.deviceLocale!.languageCode;
    }
    
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return locale.languageCode;
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
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        final locale = _getDeviceLocale();
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