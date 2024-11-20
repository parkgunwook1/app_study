import '../../../core/model/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: '이메일'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: '비밀번호'),
            obscureText: true,
          ),
          if (controller.isLoading.value)
            CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () => controller.login(
                emailController.text,
                passwordController.text,
              ),
              child: Text('로그인'),
            ),
          if (controller.errorMessage.value.isNotEmpty)
            Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.red),
            ),
        ],
      )),
    );
  }
}