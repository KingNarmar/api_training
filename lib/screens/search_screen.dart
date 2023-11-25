import 'package:api_training/componants/custom_grid_view_item.dart';
import 'package:api_training/models/product_model.dart';
import 'package:api_training/repos/controllers.dart';
import 'package:api_training/repos/dio_helper.dart';
import 'package:flutter/material.dart';
import '../repos/end_points.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    _search();
    super.initState();
  }

  void _search() {
    products = [];
    setState(() {
      isLoading = true;
    });
    DioHelper.dio
        .get(
            "$getProductsByTitleApiUrl${SearchControllers.searchController.text}")
        .then((response) {
      for (var element in response.data) {
        products.add(ProductModel.fromJson(element));
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    SearchControllers.searchController.text =
        ""; // Dispose the controller when the widget is disposed
    super.dispose();
  }

  List<ProductModel> products = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(
                onChanged: (value) {
                  SearchControllers.searchController.text = value;
                  _search();
                },
                controller: SearchControllers.searchController,
                trailing: [
                  IconButton(
                    onPressed: () {
                      _search();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ]),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : products.isEmpty
                    ? const Center(
                        child: Text("There's no Products"),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return CustomGridViewItem(
                            itme: products[index],
                            image: products[index].images![0],
                            name: products[index].title!,
                            price: products[index].price.toString(),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
