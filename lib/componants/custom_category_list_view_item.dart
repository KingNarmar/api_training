import 'package:api_training/models/category_model.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/screens/products_in_category_screen.dart';
import 'package:flutter/material.dart';

class CustomCategoryListViewItem extends StatelessWidget {
  const CustomCategoryListViewItem({
    super.key,
    this.categoryName = "cATEGORY",
    required this.category,
  });
  final String categoryName;
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorHelper.goTo(
            context, ProductsInCategoryScreen(category: category));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurStyle: BlurStyle.outer,
                blurRadius: 2,
                offset: Offset(
                  3,
                  0,
                ),
              ),
            ],
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          height: 50,
          child: Text(categoryName),
        ),
      ),
    );
  }
}
