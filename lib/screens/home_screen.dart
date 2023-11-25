import 'package:api_training/models/category_model.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:api_training/repos/navigator_helper.dart';
import 'package:api_training/repos/shared_helper.dart';
import 'package:api_training/screens/login_screen.dart';
import 'package:api_training/screens/search_screen2.dart';
import 'package:flutter/material.dart';
import '../componants/custom_category_list_view_item.dart';
import '../componants/custom_grid_view_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                NavigatorHelper.goTo(context, const SearchScreen2());
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                SharedHelper.prefs.setBool("isLogin", false);
                NavigatorHelper.goToAndOff(
                  context,
                  const LoginScreen(),
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: const Text("Home Screen"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: DioHelper.getCategory(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      for (var element in snapshot.data!.data) {
                        DioHelper.categories
                            .add(CategoryModel.fromJson(element));
                      }
                      return SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: DioHelper.categories.length,
                          itemBuilder: (context, index) {
                            return CustomCategoryListViewItem(
                              categoryName: DioHelper.categories[index].name!,
                              category: DioHelper.categories[index],
                            );
                          },
                        ),
                      );
                    default:
                      return const Center(
                        child: Text("There is Error"),
                      );
                  }
                },
              ),
              FutureBuilder(
                future: DioHelper.getProducts(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      for (var element in snapshot.data!.data) {
                        DioHelper.products.add(ProductModel.fromJson(element));
                      }
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: DioHelper.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return CustomGridViewItem(
                            image: DioHelper.products[index].images!.first,
                            name: DioHelper.products[index].title!,
                            price: DioHelper.products[index].price.toString(),
                            itme: DioHelper.products[index],
                          );
                        },
                      );

                    default:
                      return const Center(
                        child: Text("There's an Error"),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
