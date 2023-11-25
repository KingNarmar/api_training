import 'package:api_training/componants/custom_grid_view_item.dart';
import 'package:api_training/models/category_model.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductsInCategoryScreen extends StatelessWidget {
  const ProductsInCategoryScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name!),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigatorHelper.goToAndOff(
                context,
                AddProductScreen(
                  categoryModel: category,
                ));
          },
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: DioHelper.getSingleCategory(category.id!),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                List<ProductModel> categoryProducts = [];
                for (var element in snapshot.data!.data) {
                  categoryProducts.add(ProductModel.fromJson(element));
                }
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: categoryProducts.length,
                  itemBuilder: (context, index) {
                    return CustomGridViewItem(
                      itme: categoryProducts[index],
                      image: categoryProducts[index].images![0],
                      name: categoryProducts[index].title!,
                      price: categoryProducts[index].price!.toString(),
                    );
                  },
                );
              default:
                return const Center(
                  child: Text("Error"),
                );
            }
          },
        ),
      ),
    );
  }
}
