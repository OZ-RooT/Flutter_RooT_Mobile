import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodels/auth/auth_controller.dart';
import 'package:root_mobile/core/routes/app_routes.dart';
import 'package:root_mobile/core/network/api/image_api.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

final AuthController controller = Get.find();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final ImagePicker _picker = ImagePicker();
final ImageApi _imageApi = ImageApi();

class _SignupViewState extends State<SignupView> {
  bool _obscurePassword = true;
  File? _pickedFile;
  

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
              GestureDetector(
                onTap: () async {
                  final XFile? file = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
                  if (file != null) {
                    setState(() {
                      _pickedFile = File(file.path);
                    });
                  }
                },
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _pickedFile != null ? FileImage(_pickedFile!) : null,
                    child: _pickedFile == null ? Icon(Icons.add_a_photo) : null,
                  ),
                ),
              ),
              SizedBox(height: 16),
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
                    : () async {
                        final locale = _getDeviceLocale();
                        if (_pickedFile != null) {
                          final res = await _imageApi.uploadImage(_pickedFile!);
                          if (res == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('이미지 업로드에 실패했습니다')));
                            return;
                          }
                          final id = int.tryParse(res);
                          if (id == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('서버가 이미지 ID를 반환하지 않았습니다')));
                            return;
                          }
                          controller.signup(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            locale,
                            profileImageId: id,
                          );
                        } else {
                          controller.signup(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                            locale,
                          );
                        }
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