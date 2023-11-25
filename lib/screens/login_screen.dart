import 'package:api_training/repos/dio_helper.dart';

import 'package:api_training/repos/login_controllers.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/screens/create_account.dart';

import 'package:flutter/material.dart';

import '../componants/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextFormField(
                icon: const Icon(Icons.email),
                controller: LoginControllers.emailController,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                icon: const Icon(Icons.security),
                controller: LoginControllers.passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  DioHelper.login(context);
                },
                child: const Text("Login"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  NavigatorHelper.goTo(context, const CreateAccountScreen());
                },
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
