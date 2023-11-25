import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/register_controllers.dart';
import 'package:flutter/material.dart';

import '../componants/custom_text_form_field.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextFormField(
                icon: const Icon(Icons.person),
                controller: RegisterControllers.nameController,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                icon: const Icon(Icons.email),
                controller: RegisterControllers.emailController,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                icon: const Icon(Icons.security),
                controller: RegisterControllers.passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  DioHelper.createAccount(context);
                },
                child: const Text("Create Account"),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
