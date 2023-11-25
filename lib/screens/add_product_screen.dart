import 'package:api_training/componants/custom_text_form_field.dart';
import 'package:api_training/models/category_model.dart';
import 'package:api_training/repos/controllers.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/screens/products_in_category_screen.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Product In ${categoryModel.name} Category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextFormField(
                  hintText: "Title",
                  controller: CreateProductControllers.titleController),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                  hintText: "Price",
                  controller: CreateProductControllers.priceController),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                  hintText: "Discreption",
                  controller: CreateProductControllers.discreptionController),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    DioHelper.createProduct(categoryModel.id!, context);
                    NavigatorHelper.goToAndOff(context,
                        ProductsInCategoryScreen(category: categoryModel));
                    CreateProductControllers.titleController.text = "";
                    CreateProductControllers.priceController.text = "";
                    CreateProductControllers.discreptionController.text = "";
                  },
                  child: const Text("Create Product")),
            ],
          ),
        ),
      ),
    );
  }
}
